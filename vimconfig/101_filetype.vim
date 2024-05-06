"""""""""""""""""""""""""""""""""""
" filetype
"""""""""""""""""""""""""""""""""""
" Indent width
if has("autocmd")

  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  "autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et

  autocmd BufNewfile,BufRead  *.py :call PYTHONsettings()
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et

  "autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yml        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml        setlocal sw=2 sts=2 ts=2 et
  "autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et

  au BufNewFile,BufRead *.robot     setf robot
  au BufNewFile,BufRead *.launch     setf xml

  "autocmd FileType cmake  setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType CMakeLists.txt  setlocal sw=4 sts=4 ts=4 et
endif


"""""""""""""""""""""""""""""""""""
" コメント時の改行を継続しない
"""""""""""""""""""""""""""""""""""
autocmd FileType * setlocal formatoptions-=ro


"""""""""""""""""""""""""""""""""""
" cmake-format
"""""""""""""""""""""""""""""""""""
let g:cmake_format_fmt_on_save = 1
nnoremap <leader>mm :CmakeFormat -c ~/ws/dotfiles/other_config/cmake.config -o /dev/stdout<CR>


"""""""""""""""""""""""""""""""""""
" clang
"""""""""""""""""""""""""""""""""""
function! CFormat()
	!clang-format -i %
endfunction
"nnoremap <leader>cc :call CFormat()<CR>
nnoremap <leader>ff :call CFormat()<CR>


""""""""""""""""""""""""""""""""""""""
" shfmt
""""""""""""""""""""""""""""""""""""""
function! BashFormat()
	:ShFormat -i 4
endfunction
nnoremap <leader>sh :call BashFormat()<CR>


""""""""""""""""""""""""""""""""""""""
" XML format
" ref. https://qiita.com/shiena/items/8907c4b42d7958c53ce4
""""""""""""""""""""""""""""""""""""""
function! XML_FMT()
	:%s/>\s*</></g
	:%s/></>\r</g| filetype indent on | setf xml| normal gg=G
	":%s/></></g | filetype indent on | setf xml | normal gg=G
endfunction
map  <Leader>x :call XML_FMT()<CR>


""""""""""""""""""""""""""""""""""""""
" Golang format
""""""""""""""""""""""""""""""""""""""
function! GoCtags()
	let g:tagbar_type_go = {
		\ 'ctagstype' : 'go',
		\ 'kinds'     : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
		\ ],
		\ 'sro' : '.',
		\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
		\ },
		\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
		\ },
		\ 'ctagsbin'  : 'gotags',
		\ 'ctagsargs' : '-sort -silent'
	\ }
endfunction

augroup GoSetting
	autocmd BufNewFile,BufRead *.go :call GoCtags()
	autocmd BufNewFile,BufRead *.go setfiletype go
augroup END


"""""""""""""""""""""""""""""""""""
" yaml
"""""""""""""""""""""""""""""""""""
let g:ansible_options = {'ignore_blank_lines': 0}

augroup filetypedetect
  au BufRead,BufNewFile *.yaml setfiletype ansible
  au BufRead,BufNewFile *.yml  setfiletype ansible
augroup END


"""""""""""""""""""""""""""""""""""
" python
"""""""""""""""""""""""""""""""""""
function! PYTHONsettings()
	" echo "py"
	map <Leader>yy  :YapfFullFormat<CR>
endfunction
