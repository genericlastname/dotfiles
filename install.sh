#!/bin/bash

home_dir=""

## PACKAGES
packages () {
  dnf -y groupinstall "Development Tools"
  dnf -y install neovim nodejs snapd
}

neovim () {
  mkdir -p $home_dir/.config/nvim
  ln -s $(pwd)/init.vim $home_dir/.config/nvim/init.vim
  ln -s $(pwd)/coc-settings.json $home_dir/.config/nvim/coc-settings.json
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &> /dev/null
}

tmux_setup () {
  ln -s $(pwd)/tmux.conf $home_dir/tmux.conf
}

git_setup () {
  ln -s $(pwd)/gitconfig $home_dir/.gitconfig
}

bash_setup () {
  ln -s $(pwd)/bashrc $home_dir/.bashrc
}

starship_setup () {
  dnf -y install starship
  ln -s $(pwd)/starship.toml $home_dir/.config/starship.toml
}

main () {
  default=/home/$(logname)
  read -p "Enter the home directory path: " -i $default -e home_dir

  read -p "Install development packages? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) packages ;;
  esac

  read -p "Install neovim config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) neovim ;;
  esac

  read -p "Install tmux config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) tmux_setup ;;
  esac

  read -p "Install git config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) git_setup ;;
  esac

  read -p "Install bash config? [Y/n]" yn
  case $yn in
    [Nn]* ) ;;
    * ) bash_setup ;;
  esac

  read -p "Install starship and config? [Y/n]" yn
  case $yn in
    [Nn]* ) ;;
    * ) starship_setup ;;
  esac
}

main
