" sensible.vim - Defaults everyone can agree on
" Maintainer: Tim Pope <http://tpo.pe/>
" Version: 1.2

set nocompatible

" ------------
" Environment
" ------------

"Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Map leader to ,
let mapleader=','

"Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

silent function! OSX()
	return has('macunix')
endfunction
silent function! LINUX()
	return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
	return (has('win32') || has('win64'))
endfunction

set omnifunc=syntaxcomplete#Complete

" Smart mapping for tab completition
" https://vim.fandom.com/wiki/Smart_mapping_for_tab_completition
function! Smart_TabComplete()
	let line = getline('.')				" current line

	let substr = strpart(line, -1, col('.')+1)	" from the start of the current
							" line to one character right
							" of the cursor
	let substr = matchstr(substr, "[^ \t]*$")	" word till cursor
	if (strlen(substr)==0)				" nothing to match on empty string
	return "\<tab>"
endif
let has_period = match(substr, '\.') != -1	" position of period, if any
let has_slash = match(substr, '\/') != -1	" position of slash, if any
if (!has_period && !has_slash)
	return "\<C-X>\<C-P>"			" existing text matching
elseif (has_slash)
	return "\<C-X>\<C-F>"			" file matching
else
	return "\<C-X>\<C-O>"			" pluging matching
endif
endfunction

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>
						
						
if exists('g:loaded_sensible') || &compatible
finish
else
let g:loaded_sensible = 'yes'
endif

if has('autocmd')
filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal
if !has('nvim') && &ttimeoutlen == -1
set ttimeout
set ttimeoutlen=100
endif


" Use <C-L\ to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
set scrolloff=1
endif
if !&sidescrolloff
set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
set encoding=utf-8
endif

if &listchars ==# 'eol:$'
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has ("patch541")
set formatoptions+=j "Delete comment character when joining commented lines
endif

if has('path_extra')
setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
set shell=/usr/bin/env\ bash
endif

set autoread

if &history < 1000
set history=1000
endif
if &tabpagemax < 50
set tabpagemax=50
endif
if !empty(&viminfo)
set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
set t-Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit.vim') && findfile('plugin/matchit.vim', &rtp) ==# ''
runtime! macros/matchit.vim
endif

if empty(mapcheck('<C-U\', 'i'))
inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
inoremap <C-W> <C-G>u<C-W>
endif

" vim:set ft=vim et sw=2
" set update time for gitgutter
set updatetime=100

" Auto install Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https-//raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-fugitive'
Plug 'junegunn/seoul256.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-mucomplete'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
