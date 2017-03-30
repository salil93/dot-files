silent !stty -ixon

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'jelera/vim-javascript-syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

execute pathogen#infect()

set nu
set tabstop=4
set shiftwidth=4
set ai
set pastetoggle=<F3>
set t_Co=256
syntax on
set background=dark
colorscheme distinguished
set cursorline
map <F4> :NERDTreeToggle<CR>
map <F5> :!make<CR>
inoremap <F5> <esc>:!make<CR>
map <F6> :!python vim_worker.py<CR>
inoremap <C-f> <esc>
inoremap <C-s> <esc>:w<cr> :echo "Saved"<cr>i
nnoremap <C-s> <esc>:w<cr> :echo "Saved"<cr>
inoremap <C-d> <esc>:q<cr>
nnoremap <C-d> :q<cr>

" [START] Configuration for folding code
" Set a nicer foldtext function
set foldmethod=syntax
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction

highlight FoldColumn  gui=bold    guifg=white      guibg=Grey90
highlight Folded      gui=italic  guifg=white      guibg=white
highlight LineNr      gui=NONE    guifg=white      guibg=Grey90

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
" Link: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text 
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" [END] Configuration for folding code

"inoremap { {}<Left>
"inoremap ( ()<Left>

" [START] Configuration for Vim-LaTex
filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
" [END] Configuration for Vim-Latex
