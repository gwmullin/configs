set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Vim package manager
Plugin 'VundleVim/Vundle.vim'

"" Tagbar is amazing.
Plugin 'majutsushi/tagbar'

"" Useful file tree navigation
Plugin 'scrooloose/nerdtree'

"" Intelligent buffer management.
Plugin 'qpkorr/vim-bufkill'

"" Highlight indenting for when you need it.
Plugin 'nathanaelkane/vim-indent-guides'

"" Inline completion while typing - run ./install.py --clang-completer
Bundle 'Valloric/YouCompleteMe'

"" Python-specific inline completion while typing, better than YCM
Plugin 'davidhalter/jedi-vim'

"" GoLang, yo!
Plugin 'fatih/vim-go'

"" Things I want to try:
"Plugin 'ervandew/supertab'
"Plugin 'ternjs/tern_for_vim'

"" This wound up being annoying but useful:
Plugin 'scrooloose/syntastic'
"
"" Things I don't really like:
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tmhedberg/SimpylFold'


"" jedi-vim worked out much better than this
""Plugin 'klen/python-mode'

call vundle#end()
"" This maybe worked better off.
filetype plugin indent on

"" YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"" Jedi is better for python, so blacklist it for YCM here.
let g:ycm_filetype_blacklist = {
        \ 'python' : 1,
        \ }

"" Hot Key to activate Tagbar
nmap <leader>t :TagbarToggle<CR>


"" Hot Key to activate indent guides
nmap <leader>] :IndentGuidesToggle<CR>


"" Indent guides
let g:indent_guides_start_level=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=238

"" Custom tagbar highlighting for current item
highlight TagbarHighlight ctermfg=7 ctermbg=88 cterm=bold

"" golang tagbar support
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"" python-mode settings (not used)
""let g:pymode_folding = 0

""" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"" Hot Key to force syntax check
nmap <leader>x :SyntasticCheck<CR>

"" Standard VIM things below.

"" Enable folding - I HATE FOLDING
"set foldmethod=indent
"set foldlevel=99
"" Enable folding with the spacebar
"nnoremap <space> za


"" Tab between buffers
noremap <tab> :bnext<CR>
noremap <s-tab> :bprevious<CR>

"" Tab between splits
"noremap <tab> <c-w>w
"noremap <S-tab> <c-w>W

"" Switch splits with shift+arrow keys - w00t!
noremap <S-Right> <c-w>l
noremap <S-Left> <c-w>h
noremap <S-Up> <c-w>k
noremap <S-Down> <c-w>j

"" Colors
"" Useful for split-screens. Set status line up to be light gray with dark gray text.
hi StatusLine   ctermfg=48 guifg=#ffffff ctermbg=240 guibg=#4e4e4e cterm=bold gui=bold
"" Useful horizontal split colorings.
hi StatusLineNC ctermfg=0 guifg=#b3b2b2 ctermbg=240 guibg=#3a3a3a cterm=none gui=none
"" Useful vertical split colorings
hi VertSplit ctermfg=6 guifg=#b2b2b2 ctermbg=7 guibg=#3a3a3a cterm=none gui=none

"" Bring in googley paths
set path+=/usr/share/vim/google/google-filetypes/syntax

"" Always display last status line
set laststatus=2

set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

"" Change the status line based on mode
"" Status line when in 'insert' mode
au InsertEnter * hi StatusLine ctermbg=52 ctermfg=15 cterm=none gui=undercurl guisp=Magenta
"" Status line when leaving 'insert' mode
au InsertLeave * hi StatusLine ctermfg=48 ctermbg=240 cterm=bold gui=bold,reverse

"" 2 spaces for tabs
set softtabstop=2
set shiftwidth=2

"" Convert tabs to spaces
set expandtab

set ruler
set showmatch
nnoremap Q gq
set autoindent
set smartindent
inoremap # X<BS>#
set list
set lcs=tab:.\ ,trail:_
set ts=2
set nu
set sbr=+++\ 
set cpoptions=aABceFsn
set incsearch
set infercase

set splitbelow
set splitright

highlight rightMargin term=bold ctermfg=magenta guifg=magenta
"" Don't highlight the motherfucking go files line length
if empty(matchstr(expand('%:t'), '.go'))
  "" Don't highlight the motherfucking cfg files line length
  if empty(matchstr(expand('%:t'), '.cfg'))
    au BufWinEnter,VimEnter * let m1 = matchadd('rightMargin', '\%>80v.\+', -1)
  endif
endif

"" Set custom options for a few things.
au BufNewFile,BufRead *.go set lcs=tab:\ \ 
au BufNewFile,BufRead *.go set noexpandtab
au BufNewFile,BufRead *.go call clearmatches()

"" Who doesn't like syntax highlighting?!
syntax enable

"" Strip trailing whitespace from py files.
autocmd BufWritePre *.py :%s/\s\+$//e
set modeline
set modelines=10

"" Try as I might, I keep not liking mouse mode.
"set mouse=n 

"" Allow for a local vimrc file with additional things I didn't want to put in a public git repo.
if !empty(glob("$HOME/.vimrc-local"))
  source $HOME/.vimrc-local
endif

"" WTF is going on here. Jedi somehow resets these...
autocmd BufReadPost *.py :set sw=2 sts=2 ts=2

