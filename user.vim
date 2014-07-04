let s:o_lbr=&lbr
let s:o_wrap=&wrap
let &go=""
set lbr wrap stal&

func! ToggleTransparency()

    if !exists("g:transparency")
        let g:transparency=1
    else
        let g:transparency = 1 - g:transparency
    endif


    if (g:transparency)
	call libcallnr("vimtweak.dll", "SetAlpha", 210)
    else
	call libcallnr("vimtweak.dll", "SetAlpha", 255)
    endif

endfu

" configure tags - add additional tags here or comment out not-used ones
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4

" build tags of your own project with Ctrl-F12
map <C-F11> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

nmap <C-F12> :call ToggleTransparency()<CR>
nnoremap <silent> <C-F10> :TlistToggle<CR>

filetype plugin on
set ofu=syntaxcomplete#Complete

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview