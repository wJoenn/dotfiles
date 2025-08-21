#!/bin/bash

DOTFILES_CONF="$DOTFILES/sddm/theme.conf"
SDDM_CONF="/etc/sddm.conf.d/theme.conf"

DOTFILES_THEME_DIR="$DOTFILES/sddm/joenn"
SDDM_THEME_DIR="/usr/share/sddm/themes/joenn"

sudo rm -rf $SDDM_THEME_DIR
sudo cp -r $DOTFILES_THEME_DIR $SDDM_THEME_DIR
sudo chown -R root:root $SDDM_THEME_DIR

if [ -e $SDDM_CONF ] && [ ! -L $SDDM_CONF ]; then
  echo "-----> Moving $SDDM_CONF file to $SDDM_CONF.backup"
  sudo mv $SDDM_CONF "$SDDM_CONF.backup"
fi

targetdir=$(dirname $SDDM_CONF)
if [ ! -e $SDDM_CONF ]; then
  if [ ! -d $targetdir ]; then
    sudo mkdir -p $targetdir
  fi

  echo "-----> Symlinking $SDDM_CONF"
  sudo ln -s $DOTFILES_CONF $SDDM_CONF
fi
