fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-mattmc3-SLASH-zephyr/plugins/completion )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-mattmc3-SLASH-zephyr/plugins/completion/completion.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions/src )
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-peterhurford-SLASH-up.zsh )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-peterhurford-SLASH-up.zsh/up.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-rummik-SLASH-zsh-tailf )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-rummik-SLASH-zsh-tailf/tailf.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-mattmc3-SLASH-zman )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-mattmc3-SLASH-zman/zman.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-agkozak-SLASH-zsh-z )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-agkozak-SLASH-zsh-z/zsh-z.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-powerlevel10k )
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-sindresorhus-SLASH-pure )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-sindresorhus-SLASH-pure/pure.plugin.zsh
export PATH="$HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-bench:$PATH"
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/lib/clipboard.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/copybuffer )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/copybuffer/copybuffer.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/copyfile )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/copyfile/copyfile.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/copypath )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/copypath/copypath.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/extract )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/extract/extract.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/magic-enter )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/magic-enter/magic-enter.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/fancy-ctrl-z )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/history )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/history/history.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/utility )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/utility/utility.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/editor )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-belak-SLASH-zsh-utils/editor/editor.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-defer )
  source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-romkatv-SLASH-zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zdharma-continuum-SLASH-fast-syntax-highlighting )
zsh-defer source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zdharma-continuum-SLASH-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-jeffreytse-SLASH-zsh-vi-mode )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-jeffreytse-SLASH-zsh-vi-mode/zsh-vi-mode.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search )
source $HOME/.cache/antidote/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source $ZDOTDIR/.aliases
source $ZDOTDIR/.binds
source $ZDOTDIR/.functions
