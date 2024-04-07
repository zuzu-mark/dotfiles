"""""""""""""""""""""""""""""""""""
" basic settings
"""""""""""""""""""""""""""""""""""
" leader
let mapleader = "\<Space>"

" marker
set foldmethod=marker

" disable
set nowrapscan
set noswapfile
set nocompatible

" tab, indent
set smartindent
set tabstop=4
set shiftwidth=4

" display
set list
set listchars=tab:>.,trail:-,extends:>,precedes:<,nbsp:%

" paste mode
set pastetoggle=<F10>
autocmd InsertLeave * set nopaste

" keymap
nnoremap Y y$
let OSTYPE=system('uname')
if OSTYPE=="Linux\n"
	noremap <Leader>y y:wv<CR>
	noremap <Leader>p :rv!<CR>p
endif

" search
set hlsearch
set ic

" move buffer
nnoremap <silent> bp :bprevious<CR>
nnoremap <silent> bn :bnext<CR>

" open file in cursor
nnoremap <silent> fd gF

" 改行コード自動判定
set fileformats=unix,dos,mac

" エンコード自動認識
set encoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,euc-jp,sjis

" filetype
filetype plugin on
filetype indent on
syntax on

" カラースキーム適用
colorscheme molokai
set t_Co=256


"""""""""""""""""""""""""""""""""""
" Toggle relative numbering,
" and set to absolute on
" loss of focus or insert mode
"""""""""""""""""""""""""""""""""""
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

function! NoNumber()
    set nornu
    set nonu
endfunction
map <Leader>nn  :call NoNumber()<CR>


"""""""""""""""""""""""""""""""""""
" tabSpace
"""""""""""""""""""""""""""""""""""
function! TabSpace()
    set expandtab
    retab
endfunction
function! SpaceTab()
    set noexpandtab
    retab! 4
endfunction
map <Leader>ts  :call TabSpace()<CR>
map <Leader>st  :call SpaceTab()<CR>

set backspace=indent,eol,start


