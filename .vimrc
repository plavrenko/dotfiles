" Maintainer:	Pavel Lavrenko <pavel@lavrenko.info>
" Last change:  2011.04.05

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set virtualedit=all

" if we have dir called ~/.vimbackups we'll backup there
if filewritable(expand("~/.vimbackups")) == 2
    set backup		" keep a backup file
    set backupdir=~/.vimbackups
else
    set nobackup
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set langmap=ÊÃÕËÅÎÇÛİÚÈßÆÙ×ÁĞÒÏÌÄÖÜÑŞÓÍÉÔØÂÀêãõëåHçûıúèÿæù÷áğòïìäöüñşóíéôøâà;qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

" Don't use Ex mode, use Q for formatting
map Q gq

" highlighting turns off
nnoremap <cr> :noh<CR> 

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2
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
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

    augroup END

endif " has("autocmd")

"Here's a function to toggle the use of syntax-based folding for a
"c/c++/java file. It also handles folding markers. 

function! <SID>EnableFolding() 
    set foldmethod=syntax
    set foldcolumn=4 
endfunction 

:command! -nargs=0 FOLD call <SID>EnableFolding() 
map FF :FOLD<CR>

set tabstop=4 
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" Python
let python_highlight_all = 1

autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class


" omnicompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Autocomplete on Tab
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\"
    else
        return "\<c-p>"
    endif
endfunction

imap <c-r> InsertTabWrapper()
set complete=""
set complete+=.
set complete+=k
set complete+=b
