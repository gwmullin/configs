set nocompatible
set t_Co=256
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

"" Python-specific plugins, but disable completion in favor of YCM
Plugin 'davidhalter/jedi-vim'

"" GoLang, yo!
Plugin 'fatih/vim-go'

"" I do specific pylint options that make this more bearable
Plugin 'scrooloose/syntastic'

"" Embrace the airline after so much time...
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'bling/vim-bufferline'

Plugin 'vim-scripts/diffchar.vim'

"" Things I don't really like:
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'edkolev/tmuxline.vim'

"" jedi-vim worked out much better than this
""Plugin 'klen/python-mode'

call vundle#end()

if !empty($TMUX)
  "" Turn off tmux airline when entering vim
  autocmd VimEnter * silent !tmux set status off
  "" Turn off tmux airline when exiting vim
  autocmd VimLeave * silent !tmux set status on
endif

"" All my file encodings are pretty much the same, I don't need that info.
let g:airline_section_y = ''

"" I don't really like wordcount displayed
let g:airline#extensions#wordcount#enabled = 0

"" You'll need powerline patched fonts for this part
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"" Just a little tweak to make my life better
let g:airline_symbols.maxlinenr = ''

"" Alternatively you can specify custom symbols below.
"let g:airline_left_sep = '»'
"let g:airline_left_sep = ''
"let g:airline_right_sep = '«'
"let g:airline_right_sep = ''
"let g:airline_symbols.crypt = '🔒 '
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = '☰'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'

""Airline Theme spec
"let g:airline_solarized_bg="dark"
"let g:airline_theme='solarized'

""" old vim-powerline symbols
""let g:airline_left_sep = '⮀'
""let g:airline_left_alt_sep = '⮁'
""let g:airline_right_sep = '⮂'
""let g:airline_right_alt_sep = '⮃'
""let g:airline_symbols.branch = '⭠'
""let g:airline_symbols.readonly = '⭤'
""let g:airline_symbols.linenr = '⭡'

"" YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"" Turn off jedi-vim autocomplete in favor of YCM
let g:jedi#completions_enabled=0
"" But get awesome call signatures
let g:jedi#show_call_signatures=1
let g:jedi#show_call_signatures_delay=0
call jedi#configure_call_signatures()

"" Hot Key to activate Tagbar
nmap <leader>t :TagbarToggle<CR>

"" Hot Key to activate indent guides
nmap <leader>] :IndentGuidesToggle<CR>

"" Word-level diff options
let g:DiffUnit = "Word1"

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


""" Syntastic
"highlight SyntasticError ctermbg=168
highlight SyntasticWarning ctermbg=168
highlight SyntasticWarningLine ctermbg=52
highlight SyntasticErrorLine ctermbg=52
highlight SyntasticStyleErrorLine ctermbg=52
highlight SyntasticStyleWarningLine ctermbg=52
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_balloons = 1

"" If you want to place syntastic in passive mode, here's how
"let g:syntastic_mode_map = {
"  \ "mode": "active",
"  \ "passive_filetypes": ["python"] }

"" Hot Key to force syntax check
nmap <leader>x :SyntasticCheck<CR>


"" Standard VIM things (non-plugin) below.

"" Disable folding - I HATE FOLDING
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

"" Close the location window with shift + esc
noremap <leader><Esc> :lclose<CR>

"" Colors
"" Useful for split-screens. Set status line up to be light gray with dark gray text.
hi StatusLine   ctermfg=48 guifg=#ffffff ctermbg=240 guibg=#4e4e4e cterm=bold gui=bold
"" Useful horizontal split colorings.
hi StatusLineNC ctermfg=0 guifg=#b3b2b2 ctermbg=240 guibg=#3a3a3a cterm=none gui=none
"" Useful vertical split colorings
hi VertSplit ctermfg=6 guifg=#b2b2b2 ctermbg=7 guibg=#3a3a3a cterm=none gui=none

"" Alternative paren matching colors
hi MatchParen cterm=bold ctermbg=none ctermfg=164

"" Old status line configs. I use vim-airline for this now.
""" "" Always display last status line
""" set laststatus=2
""" 
""" set statusline=   " clear the statusline for when vimrc is reloaded
""" set statusline+=%-3.3n\                      " buffer number
""" set statusline+=%f\                          " file name
""" set statusline+=%h%m%r%w                     " flags
""" set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
""" set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
""" set statusline+=%{&fileformat}]              " file format
""" set statusline+=%=                           " right align
""" set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
""" set statusline+=%b,0x%-8B\                   " current char
""" set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
""" 
""" "" Change the status line based on mode
""" "" Status line when in 'insert' mode
""" au InsertEnter * hi StatusLine ctermbg=52 ctermfg=15 cterm=none gui=undercurl guisp=Magenta
""" 
""" "" Status line when leaving 'insert' mode
""" au InsertLeave * hi StatusLine ctermfg=48 ctermbg=240 cterm=bold gui=bold,reverse


"" Line length highlighting over 80 char
highlight rightMargin term=bold ctermfg=magenta guifg=magenta
"" Don't highlight the motherfucking go files line length
if empty(matchstr(expand('%:t'), '.go'))
  "" Don't highlight the motherfucking cfg files line length
  if empty(matchstr(expand('%:t'), '.cfg'))
    "" Don't highlight the motherfucking html files line length
    if empty(matchstr(expand('%:t'), '.html'))
      au BufWinEnter,VimEnter * let m1 = matchadd('rightMargin', '\%>80v.\+', -1)
    endif
  endif
endif

"" Open tagbar if we have tags available
autocmd VimEnter * nested :call tagbar#autoopen(1)

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
"" 2 spaces for tabs
set softtabstop=2
set shiftwidth=2
set ts=2
set nu
set sbr=+++\ 
set cpoptions=aABceFsn
set incsearch
set infercase

set splitbelow
set splitright

"" WTF is going on here. Jedi somehow resets these...
autocmd BufReadPost *.py :set sw=2 sts=2 ts=2

highlight DiffAdd  cterm=bold ctermbg=022 ctermfg=119
highlight DiffChange  ctermbg=022
highlight DiffDelete  cterm=bold ctermbg=052 ctermfg=124
highlight DiffText cterm=bold ctermbg=034 ctermfg=015


"" Everything below does a word-level diff against repo HEAD.
"" It's some hacky shit, but works decently well and looks awesome.
if exists("g:diffchanges_loaded")
    finish
endif

let g:diffchanges_loaded = 1

let g:diffchanges_diff = []
let g:diffchanges_patch = []
let s:diffchanges_modes = ['diff', 'patch']

if !exists('g:diffchanges_patch_cmd')
    "" This works for perforce pretty well. Pick your poison carefully...
    let g:diffchanges_patch_cmd = '/usr/bin/p4 diff'
endif

let s:save_cpo = &cpo
set cpo&vim

command! -bar -complete=file -nargs=? DiffChanges :call s:DiffChanges(<q-args>)
command! -bar DiffChangesDiffToggle :call s:DiffChangesToggle('diff')
command! -bar DiffChangesPatchToggle :call s:DiffChangesToggle('patch')
command! -bar Pdiff :call s:DiffChangesToggle('diff')

nnoremenu <script> &Plugin.&DiffChanges.&Write\ Patch  <SID>DiffChanges
nnoremenu <script> &Plugin.&DiffChanges.&Diff\ Toggle  <SID>DiffChangesDiffToggle
nnoremenu <script> &Plugin.&DiffChanges.&Patch\ Toggle <SID>DiffChangesPatchToggle

function! s:GetDiff() "{{{1
    let filename = expand('%')
    let diffname = tempname()
    execute 'silent w! '.diffname
    let diff = system(g:diffchanges_patch_cmd.' '.shellescape(filename))
    call delete(diffname)
    return diff
endfunction

function! s:GetPatchFilename(filename) "{{{1
    return a:filename.'.'.strftime('%Y%m%d%H%M%S').'.patch'
endfunction

function! s:DiffChanges(...) "{{{1
    if a:0 == 0 || len(a:1) == 0
        let filename = s:GetPatchFilename(expand('%'))
    else
        let filename = a:1
    endif
    let diff = s:GetDiff()
    call writefile(split(diff, '\n'), filename)
    echo 'Patch written to "'.filename.'"'
endfunction

function! s:DiffChangesToggle(mode) "{{{1
    if count(s:diffchanges_modes, a:mode) == 0
        call s:Warn("Invalid mode '".a:mode."'")
        return
    endif
    if len(expand('%')) == 0
        call s:Warn("Unable to show changes for unsaved buffer")
        return
    endif
    let [dcm, pair] = s:DiffChangesPair(bufnr('%'))
    if count(s:diffchanges_modes, dcm) == 0
        call s:DiffChangesOn(a:mode)
    else
        call s:DiffChangesOff()
    endif
endfunction

function! s:DiffChangesOn(mode) "{{{1
    set diffopt=filler,context:100000
    if count(s:diffchanges_modes, a:mode) == 0
        return
    endif
    let filename = expand('%')
    let buforig = bufnr('%')
    let lineorig = getline('.')
    let diff = s:GetDiff()
    if len(diff) == 0
        call s:Warn('No changes found')
        return
    endif
    if a:mode == 'diff'
        let b:diffchanges_savefdm = &fdm
        let b:diffchanges_savefdl = &fdl
        let save_winnr=winnr()
        let save_ft=&ft
        diffthis
        new
        let &ft=save_ft
        let bufname = filename.'difflocal'
        let diff_winnr=winnr()
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        execute '0read !/usr/bin/p4 print '.filename
        diffthis
    elseif a:mode == 'patch'
        below new
        setlocal filetype=diff
        setlocal foldmethod=manual
        silent 0put=diff
        1
        let bufname = s:GetPatchFilename(filename)
    endif
    silent file `=bufname`
    autocmd BufUnload <buffer> call s:DiffChangesOff()
    let bufdiff = bufnr('%')
    call add(g:diffchanges_{a:mode}, [buforig, bufdiff])
    exe diff_winnr 'hide'
endfunction

function! s:DiffChangesOff() "{{{1
    let [dcm, pair] = s:DiffChangesPair(bufnr('%'))
    execute 'autocmd! BufUnload <buffer='.pair[1].'>'
    execute 'bdelete! '.pair[1]
    execute bufwinnr(pair[0]).'wincmd w'
    if dcm == 'diff'
        diffoff
        let &fdm = b:diffchanges_savefdm
        let &fdl = b:diffchanges_savefdl
    endif
    let dcp = g:diffchanges_{dcm}
    call remove(dcp, index(dcp, pair))
endfunction

function! s:DiffChangesPair(buf_num) "{{{1
    for dcm in s:diffchanges_modes
        let pairs = g:diffchanges_{dcm}
        for pair in pairs
            if count(pair, a:buf_num) > 0
                return [dcm, pair]
            endif
        endfor
    endfor
    return [0, 0]
endfunction

function! s:Warn(message) "{{{1
    echohl WarningMsg | echo a:message | echohl None
endfunction

function! s:Error(message) "{{{1
    echohl ErrorMsg | echo a:message | echohl None
endfunction

"}}}

let &cpo = s:save_cpo

