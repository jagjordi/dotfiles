#!/usr/bin/env bash
#
# audio-switch.sh - rofi menu to switch PipeWire audio devices.
#
#   rofi -modi 'Audio:~/.config/rofi/audio-switch.sh' -show Audio
#
# Lists outputs (sinks) and inputs (sources) with the active one marked.
# Picking one makes it the default and moves every playing/recording stream
# to it. "Card profiles" opens a second level to switch a card's profile
# (e.g. analog <-> HDMI), after which the device list is shown again.
#
# Rofi script-mode protocol: rows are printed to stdout; on selection the
# script is re-run with the row text as $1 and its "info" field in $ROFI_INFO.

set -uo pipefail
export PATH="$HOME/.local/bin:$PATH"

ON="●"   # active device
OFF="○"

notify() { notify-send -a "Audio" -h string:x-canonical-private-synchronous:audio-switch -t 2500 "$@"; }

# row <text> <info> [icon] [nonselectable]
row() {
    printf '%s\0info\x1f%s' "$1" "$2"
    [[ -n "${3:-}" ]] && printf '\x1ficon\x1f%s' "$3"
    [[ -n "${4:-}" ]] && printf '\x1fnonselectable\x1ftrue'
    printf '\n'
}

esc() { sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'; }

icon_for() {  # <name> <kind>
    case "$1" in
        bluez*) echo audio-headphones ;;
        *hdmi*) echo video-display ;;
        *) [[ "$2" == sink ]] && echo audio-speakers || echo audio-input-microphone ;;
    esac
}

main_menu() {
    printf '\0markup-rows\x1ftrue\n\0prompt\x1fAudio\n'
    local idx=0 active=() name desc vol mute
    local def_sink def_source
    def_sink=$(pactl get-default-sink)
    def_source=$(pactl get-default-source)

    row "<b>Output</b>" "" "" nonselectable; ((idx++))
    while IFS=$'\t' read -r name desc vol mute; do
        local mark=$OFF; [[ "$name" == "$def_sink" ]] && { mark=$ON; active+=("$idx"); }
        [[ "$mute" == true ]] && vol="muted"
        row "$mark  $(esc <<<"$desc")  <span alpha='60%'>$vol</span>" "sink:$name" "$(icon_for "$name" sink)"
        ((idx++))
    done < <(pactl -f json list sinks | jq -r '.[] | select(.properties["node.virtual"] != "true")
        | [.name, .description, (.volume["front-left"].value_percent // ""), (.mute|tostring)] | @tsv')

    row "<b>Input</b>" "" "" nonselectable; ((idx++))
    while IFS=$'\t' read -r name desc vol mute; do
        local mark=$OFF; [[ "$name" == "$def_source" ]] && { mark=$ON; active+=("$idx"); }
        [[ "$mute" == true ]] && vol="muted"
        row "$mark  $(esc <<<"$desc")  <span alpha='60%'>$vol</span>" "source:$name" "$(icon_for "$name" source)"
        ((idx++))
    done < <(pactl -f json list sources | jq -r '.[] | select(.monitor_source == "" and .properties["node.virtual"] != "true")
        | [.name, .description, (.volume["front-left"].value_percent // ""), (.mute|tostring)] | @tsv')

    row "" "" "" nonselectable; ((idx++))
    row "Card profiles…" "profiles" "preferences-system"
    if ((${#active[@]})); then printf '\0active\x1f%s\n' "$(IFS=,; echo "${active[*]}")"; fi
}

profiles_menu() {
    printf '\0markup-rows\x1ftrue\n\0prompt\x1fProfiles\n'
    local idx=0 active=() card cdesc cactive key pdesc
    while IFS=$'\t' read -r card cdesc cactive; do
        row "<b>$(esc <<<"$cdesc")</b>" "" "" nonselectable; ((idx++))
        while IFS=$'\t' read -r key pdesc; do
            local mark=$OFF; [[ "$key" == "$cactive" ]] && { mark=$ON; active+=("$idx"); }
            row "$mark  $(esc <<<"$pdesc")" "profile|$card|$key" "audio-card"
            ((idx++))
        done < <(pactl -f json list cards | jq -r --arg c "$card" '.[] | select(.name == $c)
            | .profiles | to_entries[] | select(.value.available) | [.key, .value.description] | @tsv')
    done < <(pactl -f json list cards | jq -r '.[] | [.name, (.properties["device.description"] // .name), .active_profile] | @tsv')
    row "" "" "" nonselectable
    row "← Back" "back" "go-previous"
    if ((${#active[@]})); then printf '\0active\x1f%s\n' "$(IFS=,; echo "${active[*]}")"; fi
}

set_sink() {
    local name="$1" desc id
    pactl set-default-sink "$name" || { notify -u critical "Failed to set output" "$name"; return 1; }
    for id in $(pactl list short sink-inputs | cut -f1); do pactl move-sink-input "$id" "$name" 2>/dev/null; done
    desc=$(pactl -f json list sinks | jq -r --arg n "$name" '.[] | select(.name == $n) | .description')
    notify "Output: $desc"
}

set_source() {
    local name="$1" desc id
    pactl set-default-source "$name" || { notify -u critical "Failed to set input" "$name"; return 1; }
    for id in $(pactl list short source-outputs | cut -f1); do pactl move-source-output "$id" "$name" 2>/dev/null; done
    desc=$(pactl -f json list sources | jq -r --arg n "$name" '.[] | select(.name == $n) | .description')
    notify "Input: $desc"
}

set_profile() {
    local card="$1" profile="$2"
    if pactl set-card-profile "$card" "$profile"; then
        notify "Profile: $profile" "$card"
        sleep 0.4   # let the new sinks/sources appear
    else
        notify -u critical "Failed to set profile" "$card: $profile"
    fi
}

case "${ROFI_INFO:-}" in
    "")          main_menu ;;                       # first call, or a header row
    sink:*)      set_sink "${ROFI_INFO#sink:}" ;;
    source:*)    set_source "${ROFI_INFO#source:}" ;;
    profiles)    profiles_menu ;;
    profile\|*)  IFS='|' read -r _ card profile <<<"$ROFI_INFO"; set_profile "$card" "$profile"; main_menu ;;
    back)        main_menu ;;
    *)           main_menu ;;
esac
