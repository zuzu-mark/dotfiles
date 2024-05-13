"""""""""""""""""""""""""""""""""""
" plugin settings
" explore
"""""""""""""""""""""""""""""""""""
" 上部に表示される情報を非表示
let g:netrw_banner = 0
" 表示形式をTreeViewに変更
let g:netrw_liststyle = 3
" 左右分割を右側に開く
let g:netrw_altv = 1
" 分割で開いたときに85%のサイズで開く
let g:netrw_winsize = 25


"""""""""""""""""""""""""""""""""""
" plugin settings
" tags
"""""""""""""""""""""""""""""""""""
set tags=./tags;

"let g:tagbar_ctags_bin = '/home/ubuntu'
let g:tagbar_left = 1
nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>


"""""""""""""""""""""""""""""""""""
" plugin settings
" nerd commenter
"""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1


"""""""""""""""""""""""""""""""""""
" plugin settings
" fzf shortcut
"""""""""""""""""""""""""""""""""""
map <Leader>l   :BLines 
map <Leader>f   :GFiles<CR>


"""""""""""""""""""""""""""""""""""
" plugin settings
" vnip
"""""""""""""""""""""""""""""""""""
"https://github.com/matsui54/dotfiles/tree/master/nvim/snippets
let g:vsnip_snippet_dir = expand('~/ws/dotfiles/snip')

"
" vim-vsnip mapping.
"
"imap <expr><C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
"smap <expr><C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
"
"imap <expr><Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
"smap <expr><Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
"imap <expr><S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
"smap <expr><S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


map <Leader>sn   :SnipMateOpenSnippetFiles<CR>

"""""""""""""""""""""""""""""""""""
" plugin settings
" align
"""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
