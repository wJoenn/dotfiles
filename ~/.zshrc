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
export PATH="$HOME/.local/bin:$PATH"

# TOOLING
## fzf
type -a fzf > /dev/null && source <(fzf --zsh)

## fastfetch
if [ $TERM = "xterm-kitty" ]; then
  chafa --size 35x35 ~/.config/fastfetch/logo.webp | fastfetch --show-errors --logo-width 35 --raw -
fi

## yay
daily_yay_update

# LANGUAGES
## Node
### Load nvm if installed
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

### Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook

load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}

type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

## Ruby
### Load rbenv if installed
type -a rbenv > /dev/null && eval "$(rbenv init -)"
