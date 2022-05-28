" therabidmachine's neovim config file
" Now with folded sections!

" ---MAPPINGS--- {{{


" VIM {{{


" set leader
let mapleader = ","

" bang to instant execute
nnoremap ! :!

" add lines quickly
nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>j

" exiting insert mode
inoremap jj <Esc>

" clear search when pressing enter
nnoremap <silent> <cr> :nohl<cr>

" window switching keys
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

" map <C-e> to jump to end of line in insert mode
inoremap <C-e> <C-o>$

" map <leader>l to toggle relative line numbers
nnoremap <silent> <leader>l :set relativenumber!<cr>

" }}}
" PLUGINS {{{


" Fzf.vim keybindings
nnoremap <C-p> :Files<cr>
nnoremap <C-l> :Buffers<cr>
nnoremap <C-b> :Ag<cr>
nnoremap <C-t> :Tags<cr>

" Tmux Navigator
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

" bufkill.vim
nnoremap <silent> <leader>bd :BD<cr>

" ALE
nmap <silent> <leader>aa :ALEDetail<cr>
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" vim-dispatch
nmap <silent> <leader>mm :Make<cr>
nmap <silent> <leader>ms :Make!<cr>
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
let g:netrw_localrmdir='rm -r'
augroup netrw_mapping
    au!
    " au filetype netrw call NetrwMapping()
    " stop *.h files from being grayed out
    au filetype netrw setlocal suffixes-=.h
    au filetype netrw nnoremap <buffer> Q :bd<CR>
augroup END

" Unimpaired
Plug 'tpope/vim-unimpaired'

" Fzf and fzf.vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '25%' }

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" Vim Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

" bufkill.vim -- so i can close bufs without removing the split
Plug 'qpkorr/vim-bufkill'

" vim-dispatch -- async make
Plug 'tpope/vim-dispatch'

" vim-obsession - resurrect old tmux sessions
Plug 'tpope/vim-obsession'

" }}}
" ---UI--- {{{


" Themes
" Plug 'morhetz/gruvbox'
" Plug 'haishanh/night-owl.vim'
Plug 'sjl/badwolf'

" statusline
Plug 'itchyny/lightline.vim'
Plug '844196/lightline-badwolf.vim'
let g:lightline = {
  \ 'colorscheme': 'badwolf',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'  ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ }


" }}}
" ---Languages--- {{{


" Python
augroup ft_python
  au!
  au filetype python setlocal makeprg=python3\ %
  au filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
  au filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
  au filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
augroup END

" HTML/CSS
Plug 'mattn/emmet-vim'
augroup ft_html
  au!
  au filetype html setlocal tabstop=4
  au filetype html setlocal nowrap
  au filetype css setlocal tabstop=4
augroup END

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leshill/vim-json'

" Vimscript
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
augroup ft_vim
  au!
  au bufwritepost $MYVIMRC source $MYVIMRC
augroup END

" C++
Plug 'octol/vim-cpp-enhanced-highlight'
augroup ft_cpp
  au!
  au filetype c,cpp setlocal commentstring=//\ %s
  au filetype c,cpp setlocal tw=4 sw=4 ts=4 sts=4 expandtab
  " au filetype c,cpp setlocal tw=4 sw=4 ts=4 noexpandtab
  " au filetype c,cpp setlocal ts=8 sts=0 expandtab sw=2 smarttab
  " au filetype c,cpp setlocal foldmethod=indent foldnestmax=1
  au bufreadpre main.c,main.cc,main.cpp setlocal nofoldenable
augroup END

" Dart/Flutter
" Plug 'dart-lang/dart-vim-plugin'
" let dart_style_guide = 2
" let dart_format_on_save = 1
" augroup ft_dart
"   au!
"   au filetype dart nnoremap <leader>e :CocCommand flutter.emulators<cr>
"   au filetype dart nnoremap <leader>d :CocCommand flutter.devices<cr>
"   au filetype dart nnoremap <leader>r :CocCommand flutter.run<cr>
"   au filetype dart setlocal ts=2 sw=2
" augroup end

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
augroup ft_rust
  au!
  au filetype rust nmap gd <Plug>(rust-def)
  au filetype rust nmap gs <Plug>(rust-def-split)
  au filetype rust nmap gv <Plug>(rust-def-vertical)
  au filetype rust nmap gt <Plug>(rust-def-tab)
  au filetype rust nmap <leader>gd <Plug>(rust-doc)
  au filetype rust setlocal foldmethod=syntax
  au filetype rust setlocal foldnestmax=1
augroup end

" Markdown
augroup ft_markdown
  au!
  au filetype markdown setlocal tw=80
  au filetype markdown let b:coc_suggest_disable = 1
augroup END

" Makefile
augroup ft_make
  au!
  au filetype make set noexpandtab sw=8 sts=0
augroup END

" Lisp
Plug 'vlime/vlime', {'rtp': 'vim/'}
augroup ft_lisp
  au!
  au filetype lisp set completeopt=longest,menuone
  au filetype lisp inoremap <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  au filetype lisp inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
augroup END
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" uxntal
Plug 'karolbelina/uxntal.vim'


" }}}
" ---Coding Helpers--- {{{


" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ALE 
Plug 'w0rp/ale'
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {
  \ 'cpp': ['ccls', 'clang', 'clangtidy', 'clazy'],
  \ 'python': ['pyright', 'pylint'],
  \ 'javascript': ['eslint'],
  \ 'go': ['gofmt', 'gobuild'],
  \ }
let g:ale_fixers = {
  \ 'python': ['autopep8', 'add_blank_lines_for_python_control_statements'],
  \ 'go': ['gofmt'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ }
let g:ale_cpp_clangtidy_options = '-x c++'
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_lint_on_enter = 1
let g:ale_echo_msg_format = '[%linter%] %s'

" Neosnippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
"                                            \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Gutentags
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_generate_on_new = 0
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_write = 0
let g:gutentags_ctags_tagfile = '.tags'
" let g:gutentags_ctags_exclude = [ \
"   '.git', '.svg', '.hg', \
"   '/tests/', 'build', 'dist', 'sites//files/', 'bin', 'node_modules', 'cache',
"   'compiled', 'docs', 'example', 'bundle', 'vendor', '.md', '-lock.json', '.lock', \
"   'bundle.js', 'build.js', '.rc', '.json', '.min.', '.map', '.bak', '.zip', \
"   '.pyc', '.class', '.sln', '.Master', '.csproj', '.tmp', '.csproj.user', '.cache', \
"   '.pdb', 'tags', 'cscope.', '.css', '.less', '.scss', '.exe', '.dll', \
"   '.mp3', '.ogg', '.flac', '.swp', '.swo', '.bmp', '.gif', '.ico', '.jpg', '.png', \
"   '.rar', '.zip', '.tar', '.tar.gz', '.tar.xz', '.tar.bz2', \
"   '.pdf', '.doc', '.docx', '.ppt', '.pptx']
" let g:gutentags_generate_on_empty_buffer = 0

" " For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif


" }}}
" ---Writing--- {{{
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'

let w:ProseModeOn = 0

function EnableProseMode()
    setlocal spell spelllang=en_us
    Goyo 66
    SoftPencil
    set nonumber norelativenumber
    echo "Prose Mode On"
endfu

function DisableProseMode()
    Goyo!
    NoPencil
    setlocal nospell
    set number relativenumber
    echo "Prose Mode Off"
endfu

function ToggleProseMode()
    if w:ProseModeOn == 0
        call EnableProseMode()
        let w:ProseModeOn = 1
    else
        call DisableProseMode()
    endif
endfu

command Prose call EnableProseMode()
command UnProse call DisableProseMode()
command ToggleProse call ToggleProseMode()

nnoremap <leader>pp :call ToggleProseMode()<cr>

" }}}

call plug#end()


"}}}
" ---SETTINGS--- {{{


" basic setups and commands
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set bg=dark
colorscheme badwolf
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
  au TermOpen * set nonumber norelativenumber " turn off line numbers in the term
  au filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
set number relativenumber

augroup jj_timing
  au InsertEnter * set timeoutlen=500
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

set cindent
set cinoptions=g1,L-0.5,N-s

" set up sessions to work seamlessly
let g:sessions_dir = "~/.config/nvim/sessions"
exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/<C-D>'
exec 'nnoremap <leader>sr :so ' . g:sessions_dir . '/<C-D>'

set updatetime=300
" }}}

" # vim: set foldmethod=marker:
