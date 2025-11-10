if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Enable syntax highlighting
syntax on

" Enable file type detection and plugins
filetype plugin indent on

" Set colorscheme
colorscheme habamax
" Make background transparent
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE
highlight StatusLine guibg=NONE ctermbg=NONE
highlight StatusLineNC guibg=NONE ctermbg=NONE

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Make line numbers default and enable relative line numbers
set number
set relativenumber

" Case-insensitive searching UNLESS \C or capital letters in the search term
set ignorecase
set smartcase

" Show which line your cursor is on
set cursorline

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" Set indentation to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Keep signcolumn on by default
set signcolumn=yes

" Decrease update time
set updatetime=250

" Enable automatic reload when files change externally
set autoread

" Decrease mapped sequence wait time
set timeoutlen=600

" Configure how new splits should be opened
set splitright
set splitbelow

" Enable break indent
set breakindent

" Optionally enable 24-bit colour
if has('termguicolors')
  set termguicolors
endif

" Don't show the mode, since it's already in the status line
set noshowmode

" Save undo history
set undofile
set undolevels=1000

" Global statusline
set laststatus=3

" Enable Nerd Font
let g:have_nerd_font = 1

" Set leader key to space
let mapleader = " "
let maplocalleader = " "

" Save changes
nnoremap <C-s> :silent! w<CR>
inoremap <C-s> <Esc>:silent! w<CR>

" TABS
"
" Close the current buffer
nnoremap <leader>x :tabclose<CR>
" Buffer navigation
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprevious<CR>

" PROJECT
"
" Open project view with netrw
nnoremap <leader>pv :Ex<CR>

" Clear highlights on search when pressing <Esc> in normal mode
nnoremap <Esc> :nohlsearch<CR>

" Move selected lines up and down
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Indent in visual mode keeping selection
vnoremap < <gv
vnoremap > >gv

" Get the text highlighted in visual mode and prepare a substitute command for it
vnoremap <leader>s y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>

" YANK, PASTE AND DELETE
"
" Yank in the system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
" Paste preserving the clipboard
xnoremap p "_dP
" Paste from system clipboard
vnoremap <leader>p "+P
nnoremap <leader>p "+P
" Delete preserving clipboard
vnoremap <leader>d "_d
nnoremap <leader>d "_d
" Change preserving clipboard
vnoremap <leader>c "_c
nnoremap <leader>c "_c

" WINDOW
"
" Change window dimension
nnoremap º <C-w>+
nnoremap ª <C-w>-
nnoremap ¬ <C-w><
nnoremap ∆ <C-w>>


" Exit terminal mode with Esc Esc
tnoremap <Esc><Esc> <C-\><C-n>

" Highlight when yanking (copying) text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

