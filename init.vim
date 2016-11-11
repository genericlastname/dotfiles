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
set shiftwidth=2
set softtabstop=2

" == Plugins ==
call plug#begin('~/.vim/plugged')

Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-vinegar'
Plug 'neomake/neomake'

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
colorscheme seoul256

" == Configs ==
" -- lightline --
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ 'component': {
	\ 	'readonly': '%{&readonly?"x":""}',
	\	'lineinfo': '|| %-2v'
	\ 	}
	\ }

" -- vinegar --
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" -- deoplete --
let g:deoplete#enable_at_startup = 1

" -- neomake --
autocmd! BufWritePost,BufEnter * Neomake
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
