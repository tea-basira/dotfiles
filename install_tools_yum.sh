#!/bin/sh
#:
#以下クローンした場所によって書き換える
#toorsoo
linkPath='/home/toorsoo/work/dotfiles'
ln -s $linkPath/.zshrc ~/.zshrc
ln -s $linkPath/.bashrc ~/.bashrc
ln -s $linkPath/.vimrc ~/.vimrc
ln -s $linkPath/.tmux.conf ~/.tmux.conf
ln -s $linkPath/.gitconfig ~/.gitconfig
