#!/bin/sh

install_file="$(realpath "$0")"
dotfiles_dir="$(dirname "$install_file")"
if [ $# -eq 0 ]
  then
    echo "usage \"install.sh (.bashrc|.zshrc)\""
  else
    i3configlink="$HOME/.i3"
    if [ -e $i3configlink ]; then
      echo 'i3 config is already exists. Skippig...'
    else
      ln -s "$dotfiles_dir/i3" $i3configlink
    fi
    echo "source $dotfiles_dir/dotfiles/indexrc" >> $1
fi

