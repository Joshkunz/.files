
set nocompatible
syntax enable

"Add Pathogen
call pathogen#infect()

if has('gui_running')
	set background=light
	colorscheme solarized
endif

"Color Column
"set colorcolumn=80
"Over 84, highlight red
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>84v.\+', -1)

set number
set guifont=Dejavu\ Sans\ Mono\ 15

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
	autocmd FileType python setl noexpandtab colorcolumn=80
	" Python highlight over 84 char softlimit
	autocmd BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>84v.\+', -1)
augroup END
