ZSH="$HOME/.oh-my-zsh"

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME=robbyrussell

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast zsh-syntax-highlighting history-substring-search ssh-agent)

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# Store your own aliases in the ~/.aliases file and load them here.
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=code

# Databases
## Postgres
### Starts local PostgreSQL server
sudo /etc/init.d/postgresql start

# Languages
## Node
### Load nvm
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### Call `nvm use` automatically in a directory with a `.nvmrc` file
load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(node -v | tr -d '\r')"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version="$(nvm version "$(cat $nvmrc_path)" | tr -d '\r')"

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ $node_version != "v$(cat $HOME/.nvm/alias/default | tr -d '\r')" ]; then
      nvm use default --silent
    fi
  fi
}

type -a nvm > /dev/null && load-nvmrc

## Ruby
### Load rbenv if installed (to manage your Ruby versions)
export PATH=$HOME/.rbenv/bin:$PATH # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

### Rails and Ruby uses the local `bin` folder to store binstubs.
### So instead of running `bin/rails` like the doc says, just run `rails`
### Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Leexi
## Aws
export AWS_PROFILE=leexi-admin-dev
if [[ "$PWD"/ == "$HOME/code/joenn/leexi"/* ]] && ! aws s3 ls &> /dev/null; then
  aws configure sso --profile leexi-admin-dev --no-browser
fi

## Puppeteer
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
