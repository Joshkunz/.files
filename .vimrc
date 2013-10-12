set nocompatible
syntax enable

" Make backspace work like normal
set backspace=indent,eol,start

"read file changes
set autoread

" Let me abandon buffers with changes
set hidden

" Column numbering and file percentages
set ruler

" Enable modelines
set modeline
set modelines=1

set backupdir=.backup,~/backup/vim,.

" Maybe
" set cursorline 
" set cursorbind
" set showmatch

"Add Pathogen
call pathogen#infect()

set background=dark
if has('gui_running')
	set background=light
endif
colorscheme solarized

"Color Column
set colorcolumn=80

set number
" Linux font
set guifont=Dejavu\ Sans\ Mono\ 15
" Mac font
set guifont=Menlo\ Regular:h15

" Tabs
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set cindent
set expandtab

" nmap vj <C-w>j
" nmap vk <C-w>k

filetype plugin indent on

"Over 84, highlight red
"au BufAdd * let w:m2=matchadd('ErrorMsg', '\%>84v.\+', -1)

augroup rcCmd
	autocmd!
    " Common no-extension text-files
    autocmd BufRead *{README,readme,LICENSE,license,INSTALL,install} setl spell
    " Text spell checking
    autocmd BufRead *.{text,txt} setl spell
    " Change .md filetype to markdown by default
    autocmd BufRead *.{md,mkd,markdown} setl syn=markdown spell
    autocmd BufRead *.tex setl noautoindent spell syntax=tex

    autocmd FileType gitcommit setl spell

	" Python highlight over 84 char softlimit
	autocmd FileType python let w:m2=matchadd('ErrorMsg', '\%>84v.\+', -1)

    " Drools Hilighting
    autocmd BufRead *.drl setl syn=drools
    " Groovy hilighting in gradle buildfiles
    autocmd BufRead *.gradle setl syn=groovy
    autocmd BufRead {B,b}uildfile setl syn=ruby
    " Ninja hilighting in buildfiles
    autocmd BufRead */build.ninja setl syn=ninja
    " Forth Hilighting
    autocmd BufRead *.forth setl syn=forth
    " newLisp Hilighting
    autocmd BufRead *.lsp setl syn=newlisp
    autocmd BufRead *.clisp setl syn=lisp
augroup END
