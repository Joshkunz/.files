set nocompatible
syntax enable

"read file changes
set autoread

" Let me abbanon buffers with changes
set hidden

" Column numbering and file percentages
set ruler

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
"set colorcolumn=80
"Over 84, highlight red
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>84v.\+', -1)

set number
"Linux font
set guifont=Dejavu\ Sans\ Mono\ 15
"Mac font
set guifont=Menlo\ Regular:h15

"Tabs
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set cindent
set expandtab

filetype plugin indent on

augroup rcCmd
	autocmd!
    "autocmd BufWinEnter *.cc setl ts=2 sw=2
    "autocmd BufWinEnter *.h setl ts=2 sw=2
    " Text spell checking
    autocmd BufWinEnter *.text setl spell
    autocmd BufWinEnter *.txt setl spell
    " Change .md filetype to markdown by default
    autocmd BufWinEnter *.md setl syn=markdown
    autocmd FileType gitcommit setl spell
    autocmd FileType markdown setl spell colorcolumn=80
    autocmd BufWinEnter *.tex setl noautoindent spell colorcolumn=80 syntax=tex
    autocmd BufWinEnter *.md setl syn=markdown
	autocmd FileType python setl colorcolumn=80
	" Python highlight over 84 char softlimit
	autocmd BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>84v.\+', -1)
    " Drools Hilighting
    autocmd BufWinEnter *.drl setl syn=drools
augroup END
