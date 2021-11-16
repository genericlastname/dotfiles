#!/bin/bash

# Elevate permissions
#if [ $EUID != 0 ]; then
#    sudo "$0" "$@"
#    exit $?
#fi

home_dir=""
packages=""

## PACKAGES
important_packages () {
  packages=$packages" neovim nodejs snapd"
}

useful_extra_packages () {
  packages=$packages" bat starship"
}

neovim () {
  mkdir -p $home_dir/.config/nvim
  ln -s $(pwd)/init.vim $home_dir/.config/nvim/init.vim
  ln -s $(pwd)/coc-settings.json $home_dir/.config/nvim/coc-settings.json
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &> /dev/null
}

tmux_setup () {
  ln -s $(pwd)/tmux.conf $home_dir/.tmux.conf
  git clone https://github.com/tmux-plugins/tpm $home_dir/.tmux/plugins/tpm
}

git_setup () {
  ln -s $(pwd)/gitconfig $home_dir/.gitconfig
}

bash_setup () {
  mv $home_dir/.bashrc $home_dir/.bashrc.old
  ln -s $(pwd)/bashrc $home_dir/.bashrc
}

starship_setup () {
  ln -s $(pwd)/starship.toml $home_dir/.config/starship.toml
}

main () {
  default=/home/$(logname)
  read -p "Enter the home directory path: " -i $default -e home_dir

  read -p "Install development packages? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) important_packages ;;
  esac

  read -p "Install extra packages? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) useful_extra_packages ;;
  esac

  if [ -n "$packages" ]; then
    dnf -y groupinstall "Development Tools"
    dnf -y install $packages
  fi

  read -p "Install neovim config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) neovim; echo Done. ;;
  esac

  read -p "Install tmux config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) tmux_setup; echo Done. ;;
  esac

  read -p "Install git config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) git_setup; echo Done. ;;
  esac

  read -p "Install bash config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) bash_setup; echo Done. ;;
  esac

  read -p "Install starship config? [Y/n] " yn
  case $yn in
    [Nn]* ) ;;
    * ) starship_setup; echo Done. ;;
  esac
}

main
