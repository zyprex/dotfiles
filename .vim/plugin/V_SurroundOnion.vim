" surroundsOnion
vnoremap + <Esc>:call SurroundOnion()<cr>
" ===============================
function! SurroundOnion()
  echo "which onion skin ?"
  let onionSkin=nr2char(getchar())
  if onionSkin=~#'<\|>'
    exec "normal `>a>\<esc>`<i<\<esc>f>gvlolo"
  elseif onionSkin=~#'(\|)'
    exec "normal `>a)\<esc>`<i(\<esc>f)gvlolo"
  elseif onionSkin=~#'\[\|\]'
    exec "normal `>a]\<esc>`<i[\<esc>f]gvlolo"
  elseif onionSkin=~#'{\|}'
    exec "normal `>a}\<esc>`<i{\<esc>f}gvlolo"
  else
    exec "normal `>a".onionSkin.
    \ "\<esc>`<i".onionSkin.
    \ "\<esc>f".onionSkin."gvlolo"
  endif
endfunction


" surrounds--words 
nnoremap +< viw<esc>a><esc>hbi<<esc>lel
nnoremap +( viw<esc>a)<esc>hbi(<esc>lel
nnoremap +[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap +{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap +" viw<esc>a"<esc>hbi"<esc>lel
nnoremap +' viw<esc>a'<esc>hbi'<esc>lel
nnoremap +` viw<esc>a`<esc>hbi`<esc>lel
nnoremap +% viw<esc>a%<esc>hbi%<esc>lel

" surrounds--till line end
nnoremap +> i<<esc>$a><esc>
nnoremap +) i(<esc>$a)<esc>
nnoremap +] i[<esc>$a]<esc>
nnoremap +} i{<esc>$a}<esc>
