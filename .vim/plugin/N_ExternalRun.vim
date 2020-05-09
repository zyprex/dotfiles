if has("win32")

nnoremap <leader>! :call ExternalRun()<cr>
" ===============================
function! ExternalRun()
    let fpath = expand('<cfile>')
    if  fpath =~? '.*\.\(jpg\|png\)'
      !start <cfile>
    else | echo | endif | redraw
endfunction

endif
