ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=robbyrussell
ZSH_DISABLE_COMPFIX=true

plugins=(git gitfast history-substring-search last-working-dir zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

export EDITOR=code
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export DOTFILES="$HOME/code/dotfiles"
export PATH="$DOTFILES/bin:$PATH"

# TOOLING
## fzf
source <(fzf --zsh)

[[ $TERM = "xterm-kitty" ]] && chafa --size 35x35 ~/.config/fastfetch/logo.webp | fastfetch --show-errors --logo-width 35 --raw -
