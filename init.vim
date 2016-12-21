" =========================================
" ==== TheRabidMachine's Neovim Config ====
" =========================================

" == General Settings ==
set formatoptions-=cro " disable comment continuation

" use relative and normal numbers at once
set number
set relativenumber

set wildmode=longest,list " use more bash-like completion
set ignorecase
set cursorline

set expandtab
set shiftwidth=4
set softtabstop=4

" == Plugins ==
call plug#begin('~/.vim/plugged')

"Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'itchyny/lightline.vim'
"Plug 'morhetz/gruvbox'
Plug 'neomake/neomake'
Plug 'edkolev/tmuxline.vim'
Plug 'xolox/vim-lua-ftplugin'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'edkolev/tmuxline.vim'
"Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
"Plug 'daviesjamie/vim-base16-lightline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" == Keybindings ==
" bang to instant execute
nnoremap ! :!

" add lines quickly
nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>j

" switch buffers
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

" exiting insert mode
inoremap jj <Esc>

" clear search when pressing enter
nnoremap <silent> <CR> :nohl<CR>

" == Colorscheme ==
set bg=dark
colorscheme base16-flat

" == Configs ==
" -- lightline --
"let g:lightline = {
"            \ 'colorscheme': 'base16',
"            \ 'component': {
"            \ 	'readonly': '%{&readonly?"x":""}',
"            \	'lineinfo': '|| %-2v'
"            \ 	}
"            \ }

" -- vinegar --
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" -- deoplete --
"let g:deoplete#enable_at_startup = 1

" -- neomake --
autocmd! BufWritePost,BufEnter * Neomake
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" -- netrw --
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> q :bd<CR>
endfunction

let g:netrw_localrmdir='rm -r'

" -- tmuxline --
let g:tmuxline_powerline_separators = 0

" -- airline --
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='base16'

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
