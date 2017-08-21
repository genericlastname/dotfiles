" vimrc of kyle brown
" for vim and neovim
" plugin downloading and configs


call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'neomake/neomake'
Plug 'edkolev/tmuxline.vim'
Plug 'xolox/vim-lua-ftplugin'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jacoborus/tender.vim'
Plug 'davidhalter/jedi-vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()


" vinegar
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" netrw
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> q :bd<CR>
endfunction

let g:netrw_localrmdir='rm -r'

" tmuxline
let g:tmuxline_powerline_separators = 0

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='tender'

" ale
let g:ale_linters = {
\   'python': ['flake8'],
\}

" jedi
let g:jedi#popup_select_first = 1
autocmd FileType python setlocal completeopt-=preview
