" therabidmachine's neovim config file
" Now with folded sections!

" ---MAPPINGS--- {{{


" VIM {{{


" map escape to exit term-mode
tnoremap <esc> <C-\><C-n>

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

" set leader
let mapleader = ","

" }}}
" PLUGINS {{{


" Fzf.vim keybindings
nnoremap <C-p> :Files<cr>
nnoremap <C-l> :Buffers<cr>

" Tmux Navigator
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

" bufkill.vim
nnoremap <silent> <leader>bd :BD<cr>

" }}}


" }}}
" ---PLUGINS--- {{{


call plug#begin('~/.vim/plugged')

" ---Essentials--- {{{


" Fugitive
Plug 'tpope/vim-fugitive'

" Surround
Plug 'tpope/vim-surround'

" Repeat
Plug 'tpope/vim-repeat'

" Commentary
Plug 'tpope/vim-commentary'

" vinegar
Plug 'tpope/vim-vinegar'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
augroup netrw_mapping
    au!
    au filetype netrw call NetrwMapping()
    " stop *.h files from being grayed out
    au Filetype netrw setlocal suffixes-=.h
    au Filetype netrw nnoremap <buffer> q :BD<CR>
augroup END
let g:netrw_localrmdir='rm -r'

" Unimpaired
Plug 'tpope/vim-unimpaired'

" Fzf and fzf.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~15%' }

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" Vim Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

" bufkill.vim -- so i can close bufs without removing the split
Plug 'qpkorr/vim-bufkill'

" }}}
" ---UI--- {{{


" Themes
Plug 'morhetz/gruvbox'
Plug 'haishanh/night-owl.vim'

" Lines
Plug 'itchyny/lightline.vim'
let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'  ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }
Plug 'edkolev/tmuxline.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" }}}
" ---Languages--- {{{


" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
augroup ft_golang
  au!
  au Filetype go setlocal noet ts=4 sw=4 sts=4 "get go to use tabs
  au Filetype go nnoremap <silent> <leader>r :GoRun<cr>
augroup END

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
augroup ft_rust
  au!
  au Filetype rust nmap gd <Plug>(rust-def-split)
  au Filetype rust nnoremap <silent> <leader>r :RustRun<cr>
augroup END

" Python
Plug 'zchee/deoplete-jedi'
augroup ft_python
  au!
  au Filetype python setlocal makeprg=/usr/bin/python3\ %
augroup END
let g:deoplete#sources#jedi#python_path='/usr/bin/python3'
let g:deoplete#sources#jedi#show_docstring=0

" HTML/CSS
Plug 'mattn/emmet-vim'
augroup ft_html
  au!
  au FileType html setlocal tabstop=4
  au FileType css setlocal tabstop=4
augroup END

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'

" Vimscript
Plug 'Shougo/neco-vim'

" C++
" Plug 'tweekmonster/deoplete-clang2'
augroup ft_cpp
  au!
  au FileType c,cpp setlocal commentstring=//\ %s
augroup END

" }}}
" ---Coding Helpers--- {{{
" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 
" close preview after completion
augroup deoplete_preview
  au!
  au InsertLeave * if pumvisible() == 0 | pclose | endif
augroup END

" ALE 
Plug 'w0rp/ale'
let g:ale_linters = {
  \ 'cpp': ['clangtidy'] ,
  \ }

" }}}

call plug#end()


"}}}
" ---SETTINGS--- {{{


" basic setups and commands
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set bg=dark
let g:gruvbox_contrast_light="hard"
colorscheme night-owl
set wildmode=longest,list " use more bash-like completion
set ignorecase
set cursorline
set expandtab
set shiftwidth=2
set tabstop=2
set termguicolors
set hidden
let g:monochrome_italic_comments = 1

augroup numbers
  au!
  au BufEnter,FocusGained,InsertLeave * set relativenumber
  au BufLeave,FocusLost,InsertEnter * set norelativenumber
  au TermOpen * set nonumber " turn off line numbers in the term
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
set number relativenumber

augroup jj_timing
  au InsertEnter * set timeoutlen=200
  au InsertLeave * set timeoutlen=1000
augroup END

" Function to source only if file exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" add platform specific code for each computer
call SourceIfExists("$HOME/.config/nvim/platform.vim")


" }}}

" # vim: set foldmethod=marker:
