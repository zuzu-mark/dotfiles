#!/bin/bash

depend() {
    sudo apt-get update -y
    sudo apt-get install -y \
        jq \
        shfmt \
        clangd \
        silversearcher-ag

}
clangd_install() {
    sudo apt install curl gnupg
    curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/llvm.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/llvm.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" |
        sudo tee /etc/apt/sources.list.d/llvm.list >/dev/nul

}
check() {
    clangd --version
}
clangd_install
depend
check

######################
######################
######################
setting() {
    set -x
    DIR=dotfiles

    # backup old settings
    [[ -f ~/.bashrc ]] && sed -i "/source .*bashrc$/d" ~/.bashrc
    [[ -f ~/.bashrc ]] && sed -i "/export DOTFILES_INSTALL_DIR=.*$/d" ~/.bashrc

    # set path
    echo "export DOTFILES_INSTALL_DIR=$(pwd)" >>~/.bashrc
    echo "source $(pwd)/bashrc" >>~/.bashrc

    # set config alias
    myalias() {
        ARG=$1
        [[ -f ~/.${ARG} ]] && cp ~/.${ARG}{,.bak}
        rm -f ~/.${ARG}
        ln -s $(pwd)/${ARG} ~/.${ARG}
    }
    myalias vimrc
    myalias tmux.conf
    myalias profile

    # set vim-dir
    myalias_dir() {
        ARG=$1
        [[ -f ~/.${ARG} ]] && cp -rfd ~/.${ARG}{,.bak}
        rm -rfd ~/.${ARG}
        cp -rfd ${ARG} ~/.${ARG}
    }
    myalias_dir vim
}

DEBUG=echo
plugin() {
    find _install -maxdepth 1 -name "*.zip" | while read line; do
        #echo $line
        DIR=$(basename $line | awk -F"." '{$NF="";print $0}' | sed "s/ /./g" | sed "s/\.$//")
        #$DEBUG
        unzip -uq $line -d plugin
        #$DEBUG mv $line _install_done/
        #exit
    done
}
setting
#plugin

install_fzf() {
    ~/.vim/plugged/fzf/install
}

#sudo cp ./lib/libpcre.so.1 /usr/local/lib/
