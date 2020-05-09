" search select /  open url / search web
if has("win32")
vnoremap <silent> ?/ <Esc>:exec "/".GetVisualSelection()<cr>
vnoremap <silent> ?! <Esc>:exec "!start ".GetVisualSelection()<cr>
vnoremap <silent> ?? <Esc>:exec "!start https://www.sogou.com/web?query=".GetVisualSelection()<cr><cr>
elseif has("unix")
vnoremap <silent> ?/ <Esc>:exec "/".GetVisualSelection()<cr>
vnoremap <silent> ?! <Esc>:exec "!firefox ".GetVisualSelection()<cr>
vnoremap <silent> ?? <Esc>:exec "!firefox https://www.sogou.com/web?query=".GetVisualSelection()<cr><cr>
endif
" ====================================
" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
" Why is this not a built-in Vim script function?!
function! GetVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0 | return '' | endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction
