"""""""""""""""""""""""""""""""""""
" status line
"""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%n\:%y
set statusline+=[%{(&fenc!=''?&fenc:&enc)}]
set statusline+=[%{Getff()}]
set statusline+=%m%r\ %F%=%{tagbar#currenttag('%s\','','f')}\ [%l/%L]

function! Getff()
    if &ff == 'unix'
        return 'LF'
    elseif &ff == 'dos'
        return 'CR+LF'
    elseif &ff == 'mac'
        return 'CR'
    else
        return '?'
    endif
endfunction


"""""""""""""""""""""""""""""""""""
" clipboard
"""""""""""""""""""""""""""""""""""
" クリップボードからの貼り付け時に自動インデントを無効にする
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction


    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif


"""""""""""""""""""""""""""""""""""
" タブ操作関連
"""""""""""""""""""""""""""""""""""
" https://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = title[:8]
    "let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>

" nmap   t [Tag]
nmap   <Tab> [Tag]

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
" map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]o :tablast <bar> tabnew<CR>

" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>

" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>

" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>


"""""""""""""""""""""""""""""""""""
" utilities
"""""""""""""""""""""""""""""""""""
" write date
map <Leader>tg  :r!date +\%Y\%m\%d<CR>

" write md picture
function! MakeTodaySchedule(...)
  execute "normal a" . "![pic](./pic.svg)" . "\n"
endfunction
map <Leader>ii  :call MakeTodaySchedule()<CR>

