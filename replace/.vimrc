" remember cursor location
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

filetype on
filetype plugin indent on

set   autoindent
set   backup
set   backupdir=~/.bak
set nocompatible
set   expandtab
set   ignorecase
set   modelines=5
set   ruler
set   shiftwidth=2
set   showmatch
set   smartcase
set   softtabstop=2
set   tabstop=2
set   textwidth=90

syntax on
