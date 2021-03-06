#!/bin/bash

# Installs dot files

set -ex
set -x

need_cmd() {
    if ! command -v $1 >/dev/null 2>&1; then
        echo need $1
        exit 1
    fi
}

check_deps() {
    need_cmd curl
    need_cmd emacs
    need_cmd git
    need_cmd zsh
}

fetch_dotfiles() {
    if [ -d ~/.dotfiles ]; then
        git -C ~/.dotfiles pull
    else
        git clone https://github.com/japaric/.dotfiles ~/.dotfiles
    fi
}

install_rbenv() {
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
}

install_pure() {
    if [ -d ~/.dotfiles/pure ]; then
        git -C ~/.dotfiles/pure pull
    else
        git clone https://github.com/sindresorhus/pure ~/.dotfiles/pure
    fi
    mkdir -p ~/.zfunctions
    ln -fs ~/.dotfiles/pure/async.zsh ~/.zfunctions/async
    ln -fs ~/.dotfiles/pure/pure.zsh ~/.zfunctions/prompt_pure_setup
}

install_base16() {
    if [ -d ~/.dotfiles/base16-shell ]; then
        git -C ~/.dotfiles/base16-shell pull
    else
        git clone https://github.com/chriskempson/base16-shell ~/.dotfiles/base16-shell
    fi
    curl https://raw.githubusercontent.com/chriskempson/base16-builder/master/templates/mutt/dark.256.muttrc.erb > ~/.dotfiles/dark.256.muttrc
}

install_oh_my_zsh() {
    if [ -d ~/.dotfiles/oh-my-zsh ]; then
        git -C ~/.dotfiles/oh-my-zsh pull
    else
        git clone https://github.com/robbyrussell/oh-my-zsh ~/.dotfiles/oh-my-zsh
    fi
}

install_zsh_syntax_highlighting() {
    if [ -d ~/.dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git -C ~/.dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.dotfiles/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi
}

install_spacemacs() {
    if [ -d ~/.dotfiles/.emacs.d ]; then
        git -C ~/.dotfiles/.emacs.d pull
    else
        git clone https://github.com/syl20bnr/spacemacs ~/.dotfiles/.emacs.d
    fi
}

install_dropbox_uploader() {
    if [ -d ~/.dotfiles/Dropbox-Uploader ]; then
        git -C ~/.dotfiles/Dropbox-Uploader pull
    else
        git clone https://github.com/andreafabrizi/Dropbox-Uploader ~/.dotfiles/Dropbox-Uploader
        ln -s ~/.dotfiles/{Dropbox-Uploader,scripts}/dropbox_uploader.sh
    fi
}

mk_symlinks() {
    local files=(
        .Xmodmap
        .config/bspwm/bspwmrc
        .config/mpv/mpv.conf
        .config/redshift.conf
        .config/sxhkd/sxhkdrc
        .emacs.d
        .gdbinit
        .gitconfig
        .gtkrc-2.0
        .mutt/muttrc
        .newsbeuter/config
        .spacemacs
        .tigrc
        .tmux.conf
        .urlview
        .vimperatorrc
        .xinitrc
        .zprofile
        .zshrc
    )

    for file in ${files[*]}; do
        mkdir -p ~/$(dirname $file)
        ln -fns ~/.dotfiles/$file ~/$file
    done
}

main() {
    check_deps
    fetch_dotfiles
    install_rbenv
    install_pure
    install_base16
    install_oh_my_zsh
    install_zsh_syntax_highlighting
    install_spacemacs
    install_dropbox_uploader
    mk_symlinks
}

main
