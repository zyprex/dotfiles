set guicursor+=a:blinkon0 "no blink"
set guioptions=gt
set linespace=0
if has('win32') || has('win64')
    nnoremap <A-Space> :sim ~<CR>
"     winpos 250 65
"     set lines=20 columns=90
    set guifont=Hack_NF:h16
"     set guifont=Consolas:h16
    set guifontwide=黑体:h16
"     set guifont=Source_Code_Pro:h16
elseif has('win32unix') " Cygwin mintty
elseif has('unix') || has('linux')
    set guifont=Monaco\ 20
endif

