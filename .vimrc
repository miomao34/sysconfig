" Disable Vi compatibility
set nocompatible 

syntax enable

" Set line numbers
set number

" Enable mouse
set mouse=a

" Always show cursor
set ruler
set showcmd 

" Set command line height
set ch=1

" Disable line wrap
set nowrap

" Highlight pair brackets
set showmatch

" Set a nice theme
:colo torte

" Set editor window size
" set lines=50
" set columns=120

" Allow to switch between buffers without saving
set hidden

" Search settings 
set incsearch
set hlsearch
set ignorecase
set smartcase

" Set default encoding
set termencoding=utf8

" Set default tab size
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Use spaces instead of spaces - disabled
" set expandtab
set encoding=utf-8
set smartindent
set showmatch
set autoindent

" Configure status bar
set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set laststatus=2
set wildmenu

" Increase history size
set history=200

" Use Cyrillic symbols for navigation
set iskeyword=@,48-57,_,192-255
