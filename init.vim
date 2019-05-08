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
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l

" set leader
let mapleader = ","

" set key to quickly open vimrc
nnoremap <leader>v :e ~/projects/dotfiles/init.vim<cr>

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
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
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
augroup END
function! NetrwMapping()
    noremap <buffer> q :bd<CR>
endfunction
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

"UtilSnips
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" }}}
" ---UI--- {{{


" Themes
Plug 'morhetz/gruvbox'

" Lines
Plug 'itchyny/lightline.vim'
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'  ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }
Plug 'edkolev/tmuxline.vim'
" }}}
" ---Languages--- {{{


" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
au Filetype go setlocal noet ts=4 sw=4 sts=4 "get go to use tabs
au Filetype go nnoremap <silent> <leader>r :GoRun<cr>

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
au Filetype rust nmap gd <Plug>(rust-def-split)
au Filetype rust nnoremap <silent> <leader>r :RustRun<cr>

" Python
Plug 'zchee/deoplete-jedi'
au Filetype python setlocal makeprg=/usr/bin/python3\ %
" au FileType python setlocal foldmethod=indent |
"   \ setlocal foldnestmax=2
let g:deoplete#sources#jedi#python_path='/usr/bin/python3'
let g:deoplete#sources#jedi#show_docstring=0

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs'

" Toml
Plug 'cespare/vim-toml'

" HTML/CSS
Plug 'mattn/emmet-vim'

" Vimscript
Plug 'Shougo/neco-vim'

" LaTeX
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" C++
Plug 'tweekmonster/deoplete-clang2'

" Lua
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
let g:lua_complete_omni=1

" }}}
" ---Coding Helpers--- {{{
" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 
" close preview after completion
au InsertLeave * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_at_startup = 1

" ALE 
Plug 'w0rp/ale'
" }}}

call plug#end()
"}}}
" ---SETTINGS--- {{{


" basic setups and commands
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set bg=dark
let g:gruvbox_contrast_light="hard"
colo gruvbox
" set number
set wildmode=longest,list " use more bash-like completion
set ignorecase
set cursorline
set expandtab
set shiftwidth=2
set tabstop=2
set termguicolors
set hidden
let g:monochrome_italic_comments = 1
au TermOpen * set nonumber " turn off line numbers in the term

au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set number relativenumber
augroup numbertoggle
  au!
  au BufEnter,FocusGained,InsertLeave * set relativenumber
  au BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" }}}

" # vim: set foldmethod=marker:
