" therabidmachine's neovim config file
" Now with folded sections!

" Plugins {{{
call plug#begin('~/.vim/plugged')

" Essentials {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
" }}}
" UI {{{
Plug 'fxn/vim-monochrome'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" }}}
" Languages {{{
Plug 'w0rp/ale'
" }}}

call plug#end()

" Plugin Configs {{{
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

" lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
" }}}
"}}}
" Basic setups and commands {{{
let g:monochrome_italic_comments = 1
colorscheme monochrome
set number

set wildmode=longest,list " use more bash-like completion
set ignorecase
set cursorline

set expandtab
set shiftwidth=4
set softtabstop=4

set termguicolors

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType vimrc setlocal foldmethod=marker
" }}}
" Keybinds {{{
" bang to instant execute
nnoremap ! :!

" add lines quickly
nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>j

" exiting insert mode
inoremap jj <Esc>

" clear search when pressing enter
nnoremap <silent> <CR> :nohl<return>

" window switching keys
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" start ctrlp in buffer mode
nnoremap <C-l> :CtrlPBuffer<return>
" }}}

" # vim: set foldmethod=marker:
