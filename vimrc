
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" END OF SAMPLE FILE


" Lines from http://stevelosh.com/blog/2010/09/coming-home-to-vim/

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
set nocompatible
set modelines=0

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
" NOTE(harry) relative line numbers are a cool party trick, but I have  ultimately concluded that regular
" line numbers better satisfy the most common use case.
"set relativenumber
set number
set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"set wrap
"set textwidth=79
"set formatoptions=qrn1
set colorcolumn=110
"hi ColorColumn guibg=#444444

set list
set listchars=tab:▸\ ,eol:¬

" Useful on boxes where there is no good alternative to the ESC button. A better solution is to use Caps Lock
" as Ctrl when held down and ESC when tapped.
"inoremap hh <ESC>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR> " Remove trailing whitespace
nnoremap <leader>a :Ack 
nnoremap <leader>v <C-w>v<C-w>l " Open a new vertical pane and go to it
nnoremap <leader>h <C-w>s<C-w>j " Open a new horizontal pane and go to it

" Navigate between panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap ; :

let mapleader = ","
let maplocalleader = "'"

"au FocusLost * :wa


" From Caleb's vimrc at https://github.com/cespare/vim-config

hi ColorColumn ctermbg=darkgray

let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nmap <leader>n :NERDTreeToggle<CR>

" Change where we store swap/undo files
set dir=~/.vim/tmp/swap//
set backupdir=~/.vim/tmp/backup//
set undodir=~/.vim/tmp/undo/

set clipboard=unnamed

" I don't use s and S in normal mode much. Let's make them do something useful
" * s will break the line at the current spot and move it down.
" * S is the same, but moves it up.
nnoremap s i<CR><ESC>==
nnoremap S d$O<ESC>p==


" From http://amix.dk/vim/vimrc.html

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" Always show the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ %=\ %c\ :\ %l\ /\ %L,\ %P

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/harry/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '*PASTE MODE*  '
    else
        return ''
    endif
endfunction


" All new

set t_Co=256
"set background=dark
"colors ir_black
colors jellybeans
"colors molokai
"colors dusk
"colors Tomorrow-Night-Bright

let g:CommandTMaxFiles=40000
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTMaxHeight=20

" From http://stackoverflow.com/questions/2968548/vim-return-to-command-mode-when-focus-is-lost
autocmd FocusLost,TabLeave * call PopOutOfInsertMode()
function! PopOutOfInsertMode()
  if v:insertmode
    feedkeys("\<C-\>\<C-n>")
  endif
endfunction

" Ensure the temp dirs exist¬
if !isdirectory($HOME . "/.vim/tmp")
  call system("mkdir -p ~/.vim/tmp/swap")
  call system("mkdir -p ~/.vim/tmp/backup")
  call system("mkdir -p ~/.vim/tmp/undo")
endif

" Turn off annoying bak files
set nobackup

" Settings for VimClojure taken from https://github.com/daveray/vimclojure-easy
let vimclojure#FuzzyIndent=1
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = $HOME . "/.vim/vimclojure_lib/vimclojure-nailgun-client/ng"

let vimclojure#SplitPos = "bottom"
let vimclojure#SplitSize = 30

" Turn off annoying backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Barkeep integration
function! BarkeepForLine()
  let ignoredoutput = system("git blame " . expand("%") . " -L " . line(".") . "," . line(".") .  "| cut -d' ' -f 1 | sed 's#^#http://barkeep.sv2/commits/'`git config remote.origin.url | xargs basename | sed 's/.git$//'`'/#' | xargs open")
endfunction
map <F6> :call BarkeepForLine()<CR>

" Fix autoclose for lisp quoting. Taken from https://gist.github.com/3016992
autocmd FileType lisp,clojure let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

nmap <silent> <leader>sv :so $HOME/.vimrc<CR>
