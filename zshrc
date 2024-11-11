ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search ssh-agent asdf)

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)
unalias lt # we need `lt` for https://github.com/localtunnel/localtunnel

# Load rbenv if installed (to manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
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

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# Databases
## MongoDB
### Starts local MongoDB server
# if ! pgrep -x "mongod" > /dev/null; then
#   mongod --dbpath ~/data/db >/dev/null 2>&1 &
# fi
# echo " * Starting MongoDB v6.0.8 database server"

## PostgreSQL
### Starts local PostgreSQL server
sudo /etc/init.d/postgresql start

# Languages
## Crystal
### adema binary
export PATH="/home/joenn/.asdf/plugins/crystal/bin:$PATH"

## Go
### go binary
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

## JavaScript
### Bun (Don't know what this does)
[ -s "/home/joenn/.bun/_bun" ] && source "/home/joenn/.bun/_bun"

### Pnpm (Don't know what this does)
export PNPM_HOME="/home/joenn/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## Ruby
### Rails and Ruby uses the local `bin` folder to store binstubs.
### So instead of running `bin/rails` like the doc says, just run `rails`
### Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

## Rust
### Cargo binary (Why is this here ?)
export PATH="$HOME/.cargo/bin:$PATH"

# Tools
## Fly.io
### fly binary
export FLYCTL_INSTALL="/home/joenn/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Leexi
## Aws
export AWS_PROFILE=leexi-admin-dev
