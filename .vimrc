""""""""""""""""""""
" Elun Dai's vimrc script.
" copyright©Elundai 2015-2020
" 
" USAGE:
" 1. install plugins
"    vim
"    :PlugInstall
" 2. install ctags
"    apt install ctags
" 3. install vim-gnome for using + clipboard
"    apt install vim-gnome
""""""""""""""""""""


""""""""""""""""""""
" first settings
""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

""""""""""""""""""""
" vimrc scripts
""""""""""""""""""""
" source scripts
" ~/.vim/vimrc_keymap
" ~/.vim/vimrc_vim_plug
let vimrc_scripts = split(globpath('~/.vim', 'vimrc*'), '\n')
for vimrc_script in vimrc_scripts
    execute "source ".vimrc_script
endfor

" auto reload vimrc script
autocmd! bufwritepost .vimrc*,vimrc* source ~/.vimrc

""""""""""""""""""""
" settings
""""""""""""""""""""

" set global clipbord
set clipboard=unnamed,unnamedplus

" encodings
set encoding=utf-8
"set langmenu=zh_CN.UTF-8
"set fileencoding=utf-8
"set ambiwidth=double

set mouse=a  " allow mouse to control

set vb t_vb= "avoid beep

set history=3000
set autoread  "auto read when source has been changed
set timeoutlen=500  " time to wait short cut

" line break
"set textwidth=80 "auto new line
"set nowrap "avoid auto change line

""""""""""""""""""""
" buffers
""""""""""""""""""""
set hidden  " change buffer without save
set confirm  " ask to save other buffer when close vim
" auto write changes: autowrite | autowriteall
"set autowrite

""""""""""""""""""""
" display
""""""""""""""""""""
" curser
set ruler  " show the cursor position at right botton
set cursorline

" line number
set nu  " show line number
set rnu!  " rnu related show line number
map <leader>n :exe 'set nu!' &nu ? 'rnu!' : ''<cr>
augroup relative_numbser  " avoid to defined twice when source
    " delete all autocmd for current group
    autocmd!
    autocmd FocusGained * :set relativenumber
    autocmd FocusLost * :set norelativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
"" TIPS: in related number mode, you can use d3j to delete 3 line
""       including the current line
"" TIPS: zt -- both curser line and screen up
""       zz -- both cursr line and screen in the middle
""       zz -- both cursr line and screen down

set scrolloff=3 "at lest 3 line around the cursr

set ttimeoutlen=20 "shorten the pause when leaving insert mode

" verbose
"" 0: default
"" 9: show autocmd command
"set verbose=0

" flipping between ( and )
"set showmatch
"set matchtime=1

""""""""""""""""""""
" status
""""""""""""""""""""
set showcmd		" display incomplete commands


""""""""""""""""""""
" searching
""""""""""""""""""""
set incsearch		" do incremental searching
set magic "use magic patern
" case sensitive
"" smartcase | ignorecase
set ignorecase
set incsearch
set hlsearch  " hight light search
" avoid flipping (useless?)
"" lazyredraw | nolazyredraw
"set lazyredraw 

""""""""""""""""""""
" input
""""""""""""""""""""
if has("syntax")
    " tab or space
    set tabstop=4  " the length of a tab
    set shiftwidth=4 "when using <c-t> <c-d> in insert mode
    set expandtab "change tab into space
    set softtabstop=4 "easyer to backspace when expandtab set

    " indent setting
    "" autoindent -- Copy indent from current line when starting a new line
    "" smartindent -- Determin by syntax
    set smartindent
    "" TIPS: use :setpast and :setnopast to avoid mixup the indent
endif

" auto change fcitx
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction
function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction
autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()

""""""""""""""""""""
" file type
""""""""""""""""""""
" see help of filetype-plugin and indent-expression
filetype plugin indent on
" add custom filetype
augroup filetypedetect
    autocmd BufRead,BufNewFile *.{md,mkd,markdown} set filetype=markdown
augroup END


""""""""""""""""""""
" encodings
""""""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

""""""""""""""""""""
" font
""""""""""""""""""""
" TIPS: to set font in gvim 
"       you can set by Edit -> Select Font; and copy from Edit -> Settings window.
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
