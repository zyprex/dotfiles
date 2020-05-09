autocmd! BufNewFile *.py,*.sh exec ":call ZeroLine()"
" auto add header for some file
function! ZeroLine()
  " shell
  if &filetype == 'sh' && has('linux')
    call setline(1, "\#!/bin/bash")
  endif

  " python
  if &filetype == 'python' && has('linux')
    call setline(1, "\#!/usr/bin/env python")
    call append(1, "\# encoding: utf-8")
  elseif &filetype == 'python' " && has('win32')
    call setline(1, "\# encoding: utf-8")
  endif
  " next line
  normal Go

endfunction
