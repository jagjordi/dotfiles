# Dotfiles are managed by chezmoi

Many files under `~` and `~/.config` are managed by chezmoi. The source of
truth is `~/.local/share/chezmoi` (a git repo). **Every config change must go
through chezmoi**, never by editing only the live file.

## Workflow

1. Check whether the file is managed: `chezmoi managed | grep <name>`
2. If managed, edit the source with `chezmoi edit <path>` or edit the file under
   `~/.local/share/chezmoi` directly, then `chezmoi apply <path>`.
   Alternatively edit the live file, then `chezmoi add <path>` to sync it back.
3. If not managed but it should be: `chezmoi add <path>`.
4. Commit in the source repo: `chezmoi git -- add -A && chezmoi git -- commit -m "..."`

## Gotchas for automated/non-interactive use

- `chezmoi diff` and `chezmoi edit` open nvim (set in `~/.config/chezmoi/chezmoi.toml`)
  and will hang in a non-interactive shell. Use `chezmoi diff --use-builtin-diff`
  or `git -C ~/.local/share/chezmoi diff` instead, and `chezmoi edit` → edit the
  source file directly.
- Templated files (`*.tmpl`) must be edited in the source, not the live file,
  or `chezmoi add` will overwrite the template.
