" Boiler-plate
" ============

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set history=1000 " keep 50 lines of command line history

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

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


" From Steve Losh's blog (at http://stevelosh.com/blog/2010/09/coming-home-to-vim/)
" ======================

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
" Map rather than noremap so that tab will work with %-extenders
nmap <tab> %
vmap <tab> %

"set wrap
set textwidth=110
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

" Navigate between panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap ; :
vnoremap ; :

let mapleader = ","
let maplocalleader = "'"

nnoremap <leader>a :Ack ""<left>
" Open a new vertical pane and go to it:
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>\| <C-w>v<C-w>l
" Open a new horizontal pane and go to it:
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>- <C-w>s<C-w>j


" From Caleb's vimrc (at https://github.com/cespare/vim-config)
" ==================

hi ColorColumn ctermbg=darkgray

let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nmap <leader>n :NERDTreeTabsToggle<CR>

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
" ==================================

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>

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

" Always show the statusline
set laststatus=2

" Original statusline - this has been superseded by Powerbar
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ %=\ %c\ :\ %l\ /\ %L,\ %P

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
" =======

set t_Co=256
" Other schemes: ir_black, molokai, dusk, Tomorrow-Night-Bright
colors jellybeans

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

" Turn off annoying backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Supertab
let g:SuperTabDefaultCompletionType="<c-x><c-u>"
autocmd FileType clojure setlocal omnifunc=fireplace#omnicomplete
autocmd FileType coffee setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, '<c-n>') |
    \ endif

nnoremap <leader>ev :edit $HOME/.vimrc<CR>
nnoremap <leader>sv :source $HOME/.vimrc \| source $HOME/.gvimrc \| call RainbowParenthesesReset()<CR>

" Ctrl-p
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<leader>t'
let g:ctrlp_custom_ignore = '\.git$\|\.DS_Store$'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_switch_buffer = 'H' " Only jump to an existing buffer when c-x is pressed.

" Quickly display a markdown preview of the current buffer
map <leader>md :%w ! markdown_doctor \| bcat<CR><CR>

" Strip trailing whitespace on save
augroup trailing_whitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup end

" Turn off auto line wrapping
set formatoptions-=t
set formatoptions-=c

" Better handle bulleted lists. Inspired by http://stackoverflow.com/a/1047850
set formatoptions+=nqro
set comments-=fb:-
set comments+=n:*,n:-

let g:gitgutter_eager = 0

nnoremap <leader>b :tabnew<CR>


" Clojure-related
" ---------------

" Fireplace (vim clojure repl support) settings
set viminfo+=!

" Fix autoclose for lisp quoting. Taken from https://gist.github.com/3016992
autocmd FileType lisp,clojure let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")

" Vim-clojure-static: Correctly indent compojure and korma macros, etc.
let g:clojure_fuzzy_indent_patterns = "with.*,def.*,let.*,send.*,if.*,when.*,partition"
let g:clojure_fuzzy_indent_patterns .= ",GET,POST,PUT,PATCH,DELETE,context"          " Compojure
let g:clojure_fuzzy_indent_patterns .= ",clone-for"                                  " Enlive
let g:clojure_fuzzy_indent_patterns .= ",select.*,insert.*,update.*,delete.*,with.*" " Korma
let g:clojure_fuzzy_indent_patterns .= ",fact,facts"                                 " Midje
let g:clojure_fuzzy_indent_patterns .= ",up,down,alter,table"                        " Lobos
let g:clojure_fuzzy_indent_patterns .= ",check,match,url-of-form"                    " Misc

" Rainbow_parentheses settings
let g:rbpt_max = 10
let g:rbpt_colorpairs = [
    \ ['gray',      'HotPink1'],
    \ ['darkred',   'cyan1'],
    \ ['darkcyan',  'brown1'],
    \ ['darkgreen', 'yellow1'],
    \ ['darkblue',  'MediumOrchid'],
    \ ['gray',      'DeepSkyBlue1'],
    \ ['darkred',   'DarkOrange1'],
    \ ['darkcyan',  'LimeGreen'],
    \ ['darkgreen', 'goldenrod1'],
    \ ['darkblue',  'RoyalBlue1'],
    \ ]
function! RainbowParenthesesReset()
  RainbowParenthesesActivate
  RainbowParenthesesLoadRound
  RainbowParenthesesLoadSquare
  RainbowParenthesesLoadBraces
endfunction
augroup rainbow_parentheses
  autocmd!
  autocmd Filetype clojure RainbowParenthesesActivate
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
augroup end

" Hack to get around annoying interaction between vim and guard
"autocmd BufEnter handler.clj edit \| set filetype=clojure

" Make vim break autocompleted words on /'s
set iskeyword-=\/

" Have command-t ignore build files
:set wildignore+=*.o,*.class,*asset-cache*

" Evaluate outermost s-expr with fireplace
:nnoremap cpo :Eval<cr>
