" autopages
if has("timers")

nnoremap <F6> :call AutoPages(20)<cr>
"===============================
let auto_page_latch=1
function! AutoPages(wait_ms)
  let g:auto_page_latch=g:auto_page_latch==0?1:0
  set guicursor+=n:hor15-blinkon0
  call timer_start(a:wait_ms, 'AutoPageDo',{'repeat':-1})
endfunction
func! AutoPageDo(ap_timer_id)
  if g:auto_page_latch==1 
    call timer_stop(a:ap_timer_id)
    set guicursor-=n:hor15-blinkon0
    echo "AutoPages Stopped"
  else
    if line('.')==line('$') && col('.')>=col('$')-1
      call timer_stop(a:ap_timer_id)
      let g:auto_page_latch=1
      set guicursor-=n:hor15-blinkon0
      echo "AutoPages Reach EOF!"
    elseif line('.')==line('w$') && col('.')>=col('$')-1 && line('.')!=line('$')
      call feedkeys("zt\<c-e>",'n')
    elseif col('.') >= col('$') -1
      call setpos('.', [0, line('.')+1, 1, 0, 1])
    else  
      call setpos('.', [0, line('.'), col('.')+1, 0, 1])
      exec "redraws"
      echo "AutoPages Running...press <F6> to stop"
    endif
  endif
  " echo 'Handler called'
endfunc

endif
