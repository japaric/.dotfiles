#!/bin/bash

# Installs dot files

set -e
set -x

if [ -d ~/.dotfiles ]; then
  git -C ~/.dotfiles pull
else
  git clone https://github.com/japaric/.dotfiles ~/.dotfiles
fi

# rbenv
if [ -d ~/.rbenv ]; then
  git -C ~/.rbenv pull
else
  git clone https://github.com/rbenv/rbenv ~/.rbenv
fi

if [ -d ~/.rbenv/plugins/ruby-build ]; then
  git -C ~/.rbenv/plugins/ruby-build pull
else
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build ~/.rbenv/plugins/ruby-build
fi

# pure prompt
if [ -d ~/.dotfiles/pure ]; then
  git -C ~/.dotfiles/pure pull
else
  git clone https://github.com/sindresorhus/pure ~/.dotfiles/pure
fi
mkdir -p ~/.zfunctions
ln -fs ~/.dotfiles/pure/async.zsh ~/.zfunctions/async
ln -fs ~/.dotfiles/pure/pure.zsh ~/.zfunctions/prompt_pure_setup

# base16
if [ -d ~/.dotfiles/base16-shell ]; then
  git -C ~/.dotfiles/base16-shell pull
else
  git clone https://github.com/chriskempson/base16-shell ~/.dotfiles/base16-shell
fi
curl https://raw.githubusercontent.com/chriskempson/base16-builder/master/templates/mutt/dark.256.muttrc.erb > ~/.dotfiles/dark.256.muttrc

# oh-my-zsh
if [ -d ~/.dotfiles/oh-my-zsh ]; then
  git -C ~/.dotfiles/oh-my-zsh pull
else
  git clone https://github.com/robbyrussell/oh-my-zsh ~/.dotfiles/oh-my-zsh
fi

# zsh-syntax-highlighting
if [ -d ~/.dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git -C ~/.dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Vundle
if [ -d ~/.vim/bundle/Vundle.vim ]; then
  git -C ~/.vim/bundle/Vundle.vim pull
else
  mkdir -p ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
fi

# create shims (only for exherbo, where only prefixed build tools exist)
bins=(
  addr2line
  ar
  as
  c++
  c++filt
  cc
  dwp
  elfedit
  g++
  gcc
  gcov
  gfortran
  gprof
  ld
  nm
  objcopy
  objdump
  ranlib
  readelf
  size
  strings
  strip
)

mkdir -p ~/.shims
for bin in ${bins[*]}; do
  [ -f /usr/bin/$bin ] || ln -fs /usr/bin/x86_64-pc-linux-gnu-$bin ~/.shims/$bin
done

# create symlinks
files=(
  .Xmodmap
  .config/bspwm/bspwmrc
  .config/mpv/mpv.conf
  .config/redshift.conf
  .config/sxhkd/sxhkdrc
  .gdbinit
  .gitconfig
  .gtkrc-2.0
  .mutt/muttrc
  .newsbeuter/config
  .scripts
  .tigrc
  .tmux.conf
  .urlview
  .vimperatorrc
  .vimrc
  .xinitrc
  .zprofile
  .zshrc
)

for file in ${files[*]}; do
  mkdir -p ~/$(dirname $file)
  ln -fns ~/.dotfiles/$file ~/$file
done
