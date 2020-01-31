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

" map <C-e> to jump to end of line in insert mode
inoremap <C-e> <C-o>$

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

" ALE
nmap <silent> <leader>aa :ALEDetail<cr>
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" vim-dispatch
nmap <silent> <leader>cc :Make<cr>
nmap <silent> <leader>ca :Make!<cr>

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
    " au filetype netrw call NetrwMapping()
    " stop *.h files from being grayed out
    au filetype netrw setlocal suffixes-=.h
    au filetype netrw nnoremap <buffer> Q :bd<CR>
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

" vim-dispatch -- async make
Plug 'tpope/vim-dispatch'

" vim-obsession - resurrect old tmux sessions
Plug 'tpope/vim-obsession'

" }}}
" ---UI--- {{{


" Themes
Plug 'morhetz/gruvbox'
Plug 'haishanh/night-owl.vim'
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
augroup END
autocmd filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>

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
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leshill/vim-json'

" Vimscript
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
au bufwritepost $MYVIMRC source $MYVIMRC

" C++
Plug 'octol/vim-cpp-enhanced-highlight'
augroup ft_cpp
  au!
  au filetype c,cpp setlocal commentstring=//\ %s
augroup END

" Dart/Flutter
Plug 'dart-lang/dart-vim-plugin'
let dart_style_guide = 2
let dart_format_on_save = 1
augroup ft_dart
  au!
  au filetype dart nnoremap <leader>e :CocCommand flutter.emulators<cr>
  au filetype dart nnoremap <leader>d :CocCommand flutter.devices<cr>
  au filetype dart nnoremap <leader>r :CocCommand flutter.run<cr>
  au filetype dart setlocal ts=2 sw=2
augroup end

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
augroup ft_rust
  au filetype rust nmap gd <Plug>(rust-def)
  au filetype rust nmap gs <Plug>(rust-def-split)
  au filetype rust nmap gv <Plug>(rust-def-vertical)
  au filetype rust nmap gt <Plug>(rust-def-tab)
  au filetype rust nmap <leader>gd <Plug>(rust-doc)
augroup end

" Markdown
augroup md_formatting
    autocmd!
    au filetype markdown setlocal tw=8
    au InsertLeave *.md normal gwap<CR>
augroup END

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
  \ 'python': ['flake8', 'pylint'],
  \ 'javascript': ['eslint'],
  \ 'go': ['gofmt', 'gobuild'],
  \ }
let g:ale_fixers = {
  \ 'python': ['autopep8', 'add_blank_lines_for_python_control_statements', 'trim_whitespace', 'remove_trailing_lines'],
  \ 'go': ['gofmt', 'trim_whitespace', 'remove_trailing_lines'],
  \ 'javascript': ['trim_whitespace', 'remove_trailing_lines'],
  \ }
let g:ale_cpp_clangtidy_options = '-x c++'
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_lint_on_enter = 1
let g:ale_echo_msg_format = '[%linter%] %s'

" Neosnippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


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
  au TermOpen * set nonumber " turn off line numbers in the term
  au filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
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

set cindent
set cinoptions=g-1

" set up sessions to work seamlessly
" let g:sessions_dir = "~/.vim/sessions"
" exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/<C-D>'
" exec 'nnoremap <leader>sr :so ' . g:sessions_dir . '/<C-D>'

nnoremap <leader>ss :Obsess<cr>
nnoremap <leader>sr :source Session.vim<cr>
" session freeze
nnoremap <leader>sf :Obsession<cr>
function! GetSessionName()
  if exists('v:this_session') && v:this_session != ''
    let s:session_string = v:this_session
    let s:session_parts = split(s:session_string, '/')
    let s:session_filename = s:session_parts[-1]
    let s:final = ' ' . s:session_filename . ' '
    echo s:final
  endif
endfunction

" }}}

" # vim: set foldmethod=marker:
