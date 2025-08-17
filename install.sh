#!/bin/bash

CURRENT_DIR=$PWD
DIR="/home/$(whoami)/code/dotfiles/ROOT"

backup() {
  file=$1
  target=$2

  if [ -e $target ] && [ ! -L $target ]; then
    echo "-----> Moving $target file to $target.backup"
    mv $target "$target.backup"
  fi
}

symlink() {
  file=$1
  target=$2
  targetdir=$(dirname $target)

  if [ ! -e $target ]; then
    if [ ! -d $targetdir ]; then
      sudo mkdir -p $targetdir
    fi

    echo "-----> Symlinking $target"
    sudo ln -s $file $target
  fi
}

ZSH_PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p $ZSH_PLUGIN_DIR && cd $ZSH_PLUGIN_DIR
if [ ! -d "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugins..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi

cd $CURRENT_DIR

find $DIR -type f -print0 | while IFS= read -r -d '' file; do
  raw_target="${file##$DIR}"
  target="${raw_target/user/$(whoami)}"

  backup $file $target
  symlink $file $target
done

exec zsh
