#!/bin/zsh
yum install ncurses ncurses-devel
wget http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxvf vim-7.4.tar.bz2
cd vim74/
mkdir patch
cd patch
seq -f http://ftp.vim.org/pub/vim/patches/7.4/7.4.%03g 488 | xargs wget
cd ..
cat patch/7.4.* | patch -p0
./configure
make
make install
