" Key Mappings
:noremap <Up> gk
:noremap! <Up> <C-O>gk
:noremap <Down> gj
:noremap! <Down> <C-O>gj

" the following are optional, to move by file lines using Alt-arrows
:noremap! <M-Up> <Up>
:noremap! <M-Down> <Down>
:noremap <M-Up> k
:noremap <M-Down> j

set nocompatible              " be iMproved, required
filetype off                  " requiredTM4C123
filetype plugin on
syntax on

" Vim tries the paths from left to right. This line tells Vim 
" to try the currentTM4C123 directory, else try /path/vim/can/write/to
set directory=.,$TEMP

" show me where i am
set cursorline

"Remove initial message
set shortmess+=I

" show cursor position all the time
set ruler
 
" line numbering
set rnu

"making utf-8 default
set enc=utf-8

function! SetupLatex(arg)
    if a:arg == 'pdf'
        let a:targetformat = 'pdf'
    elseif a:arg == 'dvi'
        let a:targetformat = 'dvi'
    elseif a:arg == ''
        if g:Tex_DefaultTargetFormat == 'dvi'
            let a:targetformat = 'pdf'
        else
            let a:targetformat = 'dvi'
        endif
    endif
 
    if a:targetformat == 'dvi'
        " target for latex
        let g:Tex_DefaultTargetFormat = 'dvi'
        " inverse search -- start gvim as "gvim --servername xdvi"
        "let g:Tex_CompileRule_dvi = 'latex --src -interaction nonstopmode $*'
        "let g:Tex_CompileRule_dvi = 'latex --src -interaction nonstopmode $*; if pgrep -fx "xdvi.bin -name xdvi -editor gvim --servername vim --remote +%l %f $*"; then wmctrl -a "xdvik:  $*"; fi;'
        let g:Tex_CompileRule_dvi = 'latex --src -interaction nonstopmode $*; if pgrep "xdvi.bin"; then wmctrl -a "xdvik:"; fi;'
        let g:Tex_ViewRule_dvi = 'xdvi -editor "gvim --servername vim --remote +\%l \%f" -watchfile 1 $* &'
        map \ld :execute '!xdvi -editor "gvim --servername '.v:servername.' --remote +\%l \%f" -sourceposition '.line(".").':'.col(".").expand("%").' '.expand(Tex_GetMainFileName(':r')).'.dvi >/dev/null&'<CR><CR>
    else " pdf
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_CompileRule_pdf = 'pdflatex -interaction nonstopmode $*; if pgrep -fx "xpdf -remote vimlatex $*.pdf"; then xpdf -remote vimlatex -reload && wmctrl -a "Xpdf: $*.pdf"; fi;'
        "let g:Tex_CompileRule_pdf = 'pdflatex -interaction nonstopmode $*; if pgrep -fx "xpdf -remote vimlatex $*.pdf"; then xpdf -remote vimlatex -reload -raise; fi;'
        let g:Tex_CompileRule_pdf = 'pdflatex -interaction nonstopmode $*; if pgrep -fx "xpdf -remote vimlatex $*.pdf"; then xpdf -remote vimlatex -reload && wmctrl -a "Xpdf: $*.pdf"; fi;'
        let g:Tex_ViewRule_pdf = 'xpdf -remote vimlatex'
    endif
endfunction
 
if exists("myTeXtarget")
    :call SetupLatex(myTeXtarget)
    let g:Tex_MultipleCompileFormats = 'dvi,pdf'
 
    " include cross referenced references also if they are cross referenced less
    " than two times
    let g:Tex_BibtexFlavor = 'bibtex -min-crossrefs=1'
    " let the cursor in the tex buffer if an error occured
    let g:Tex_GotoError = 0
    let g:Tex_IgnoredWarnings =
                \'Underfull'."\n".
                \'Overfull'."\n".
                \'specifier changed to'."\n".
                \'You have requested'."\n".
                \'Missing number, treated as zero.'."\n".
                \'There were undefined references'."\n".
                \'Latex Warning:'."\n".
                \'LaTeX Warning:' " float stuck
                "\'Citation %.%# undefined'
    let g:Tex_IgnoreLevel = 8
    let g:Tex_FoldedEnvironments = 'frame,verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage'
endif
 
" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin 'tpope/vim-fugitive'
Plugin 'yegappan/mru'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
"Plugin 'Lokaltog/powerline'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/octave.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'itchyny/lightline.vim'
Plugin 'jceb/vim-orgmode'
Plugin 'junegunn/goyo.vim'

" Latexmk setup
"let g:LatexBox_latexmk_options = '-c -pdf'

au BufRead,BufNewFile *.md set filetype=markdown
"autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
"behave mswin
"just configuration for such hostile environment as Windows {{{
if has("win32") || has("win16")
	" source $USERPROFILE/vimfiles/colors/gruvbox.vim
	" isource $VIMRUNTIME/colors/peachpuff.vim
        set background=dark
	source $USERPROFILE/vimfiles/colors/solarized.vim
	source $USERPROFILE/vimfiles/user.vim 

	" font
	set guifont=DejaVu\ Sans\ Mono\ 8
else
	" font
	set guifont=DejaVu\ Sans\ Mono\ 12
        source ~/vimfiles/user.vim	
endif

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
  set background=dark
  source ~/vimfiles/colors/solarized.vim
else
  " This is console Vim.
  set background=dark
  let g:solarized_termcolors=256
  source ~/vimfiles/colors/solarized.vim
  " fix color scheme on terminal
  set t_Co=256
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

autocmd FileType matlab map <buffer> <f5> maggOpkg load all<esc>Gopause<esc>:w<cr>:!octave -qf %<cr>ddggdd:w<cr>

" Nerdtree toggle on/off on F3
nmap <silent> <F3> :NERDTreeToggle<CR>


