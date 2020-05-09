set nocompatible
nnoremap s <NOP>
let mapleader='s'
filetype plugin indent on
language en_US.utf8
" windows compatible
if has('win32') || has('win64')
    set rtp+=$HOME/.vim 
    set makeprg=mingw32-make
"   \ -f\ ../Makefile
endif
" set makeprg=gcc\ %\ -Wall\ -lpthread


" configure your own environment variable here!
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~tags
set tags=./tags,tags,../tags;
if has('win32')
"     autocmd! BufEnter *.c,*.cpp 
"     autocmd! BufLeave *.c,*.cpp 
    set tags+=C:/MinGW/mingw64-win32-seh/x86_64-w64-mingw32/include/tags
elseif has('win32unix')
    set tags+=/c/MinGW/mingw64-win32-seh/x86_64-w64-mingw32/include/tags
elseif has('unix') || has('linux')
    set tags+=/usr/include/tags
endif
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~path
if has('win32')
    set path+=C:/MinGW/mingw64-win32-seh/x86_64-w64-mingw32/include
elseif has('win32unix')
    set path+=/c/MinGW/mingw64-win32-seh/x86_64-w64-mingw32/include
elseif has('unix') || has('linux')
    set path+=/usr/include/i386-linux-gnu/
endif


" FOR KERNEL DRIVER:
if has("linux")
"     set tags+=/home/linux/kernel/kernel-3.4.39/tags
"     set path+=/home/linux/kernel/kernel-3.4.39
"     set path+=/home/linux/kernel/kernel-3.4.39/include/
elseif has('win32')
"     set tags+=D:/HQYJ/kernel-3.4.39-ok/kernel-3.4.39/tags
" TEMP_PATH:
" adjust boot shell command at ...
" /home/linux/nfs/rootfs/etc/init.d/rcS
endif


" FOR OTHERT:
" temp of var here ...
set path+=F:\Xprogram\cgui\SDL\SDL2-2.0.10\i686-w64-mingw32\include\SDL2
set tags+=F:\Xprogram\cgui\SDL\SDL2-2.0.10\i686-w64-mingw32\include\SDL2\tags
