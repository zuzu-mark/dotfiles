call plug#begin('~/.vim/plugged')

"" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" utils
Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'

"" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-icons'
Plug 'mattn/vim-lsp-settings'

"" completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'Shougo/ddc.vim'
Plug 'shun/ddc-vim-lsp'

" snip
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

"" language settings
Plug 'umaumax/vim-format'
Plug 'mattn/vim-goaddtags'
Plug 'pignacio/vim-yapf-format'
Plug 'chase/vim-ansible-yaml'

"" other
Plug 'vim-scripts/Align'
Plug 'garbas/vim-snipmate'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'

call plug#end()


source ~/ws/dotfiles/vimconfig/201_lsp.vim
source ~/ws/dotfiles/vimconfig/101_main.vim
source ~/ws/dotfiles/vimconfig/101_filetype.vim
source ~/ws/dotfiles/vimconfig/102_func.vim
source ~/ws/dotfiles/vimconfig/103_plugin_config.vim
