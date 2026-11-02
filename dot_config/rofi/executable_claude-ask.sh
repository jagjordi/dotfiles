#!/usr/bin/env bash
#
# claude-ask.sh - quick questions to Claude Code from a rofi prompt.
#
#   claude-ask.sh              prompt for a question (recent ones are listed)
#   claude-ask.sh "question"   skip the prompt
#
# The question is sent to `claude -p` in the background (a notification shows
# while it thinks), then the answer pops up in rofi with a few actions:
# copy, follow-up (same session), open the session in a terminal, new question.
#
# Tunables (environment variables):
#   ROFI_CLAUDE_MODEL   model alias/id        (default: haiku)
#   ROFI_CLAUDE_EFFORT  low|medium|high       (default: low)
#   ROFI_CLAUDE_TOOLS   tools claude may use  (default: WebSearch,WebFetch; "" = none)
#   ROFI_CLAUDE_WIDTH   wrap answer at N cols (default: 90)

set -uo pipefail

# Hyprland/rofi launch with a minimal PATH; claude lives in ~/.local/bin
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

MODEL="${ROFI_CLAUDE_MODEL:-haiku}"
EFFORT="${ROFI_CLAUDE_EFFORT:-low}"
TOOLS="${ROFI_CLAUDE_TOOLS-WebSearch,WebFetch}"
WIDTH="${ROFI_CLAUDE_WIDTH:-90}"
TIMEOUT="${ROFI_CLAUDE_TIMEOUT:-180}"
ROFI="${ROFI_CMD:-rofi}"
TERMINAL="${TERMINAL:-kitty}"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/rofi-claude"
HISTORY="$STATE_DIR/history"   # previous questions, newest first
LOG="$STATE_DIR/log.md"        # every question and answer
ERR="$STATE_DIR/claude.stderr"
mkdir -p "$STATE_DIR"
touch "$HISTORY"

SYSTEM_PROMPT="You are answering a quick question typed into a small desktop popup. \
Reply in plain text only: no markdown, no headings, no bullet markers, no code fences. \
Be brief and direct; a few sentences at most unless more is clearly needed. \
If a command or snippet is the answer, put it on its own line."

ACT_COPY="󰆏  Copy answer"
ACT_FOLLOW="  Follow-up"
ACT_TERM="  Continue in terminal"
ACT_NEW="  New question"

pango_escape() { sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'; }

copy() {
    if [[ -n "${WAYLAND_DISPLAY:-}" ]] && command -v wl-copy >/dev/null; then
        printf '%s' "$1" | wl-copy
    else
        printf '%s' "$1" | xclip -selection clipboard
    fi
    notify-send -a "Claude" -t 2000 "Copied to clipboard"
}

# ask_question [prompt] -> prints the question, empty if cancelled
ask_question() {
    local prompt="${1:-Ask Claude}"
    head -n 20 "$HISTORY" | "$ROFI" -dmenu -i -p "$prompt" -l 8 \
        -theme-str 'window { width: 50%; }' \
        -mesg "<i>Type a question, or pick a recent one</i>"
}

remember() {
    local tmp
    tmp=$(mktemp)
    { printf '%s\n' "$1"; grep -vxF -- "$1" "$HISTORY"; } | head -n 200 > "$tmp"
    mv "$tmp" "$HISTORY"
}

# ask_claude <question> <session-id> <resume:0|1> -> prints the answer
ask_claude() {
    local question="$1" session="$2" resume="$3"
    local args=(-p --model "$MODEL" --effort "$EFFORT" --tools "$TOOLS"
                --append-system-prompt "$SYSTEM_PROMPT" --output-format text)
    if [[ -n "$TOOLS" ]]; then args+=(--allowedTools "$TOOLS"); fi
    if (( resume )); then args+=(--resume "$session"); else args+=(--session-id "$session"); fi

    local nid
    nid=$(notify-send -a "Claude" -p -t "$((TIMEOUT * 1000))" "Thinking…" "$question")

    local answer rc
    answer=$(cd "$STATE_DIR" && timeout "$TIMEOUT" claude "${args[@]}" -- "$question" 2>"$ERR" </dev/null)
    rc=$?

    if (( rc != 0 )) || [[ -z "$answer" ]]; then
        notify-send -a "Claude" -r "$nid" -u critical -t 8000 "Claude failed (exit $rc)" \
            "$(tail -n 3 "$ERR" | pango_escape)"
        exit 1
    fi
    notify-send -a "Claude" -r "$nid" -t 1 "Done"
    {
        printf '\n## %s\n\n**Q:** %s\n\n%s\n' "$(date '+%Y-%m-%d %H:%M')" "$question" "$answer"
    } >> "$LOG"
    printf '%s' "$answer"
}

# show_answer <question> <answer> -> prints the selected row
show_answer() {
    local question="$1" answer="$2"
    {
        printf '%s\n%s\n%s\n%s\n' "$ACT_COPY" "$ACT_FOLLOW" "$ACT_TERM" "$ACT_NEW"
        printf '%s\n' "$answer" | fold -s -w "$WIDTH"
    } | "$ROFI" -dmenu -i -no-custom -p "Claude" -l 18 \
        -theme-str 'window { width: 60%; } listview { dynamic: true; }' \
        -mesg "<b>$(printf '%s' "$question" | pango_escape)</b>"
}

main() {
    local question="${1:-}" session resume=0 answer choice
    [[ -z "$question" ]] && question=$(ask_question)
    [[ -z "$question" ]] && exit 0
    session=$(cat /proc/sys/kernel/random/uuid)

    while true; do
        remember "$question"
        answer=$(ask_claude "$question" "$session" "$resume") || exit 1
        choice=$(show_answer "$question" "$answer")

        case "$choice" in
            "$ACT_COPY")   copy "$answer"; exit 0 ;;
            "$ACT_FOLLOW") resume=1
                           question=$(ask_question "Follow-up")
                           [[ -z "$question" ]] && exit 0 ;;
            "$ACT_TERM")   exec "$TERMINAL" --class floating --directory "$STATE_DIR" \
                               -- claude --resume "$session" ;;
            "$ACT_NEW")    resume=0; session=$(cat /proc/sys/kernel/random/uuid)
                           question=$(ask_question)
                           [[ -z "$question" ]] && exit 0 ;;
            "")            exit 0 ;;
            *)             copy "$choice"; exit 0 ;;   # an answer line: copy just that line
        esac
    done
}

main "$@"
