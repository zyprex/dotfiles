" Cmm comment 
nnoremap <space>m :call CmmComment()<cr>
vnoremap <space>m :call CmmComment()<cr>
command! -range CmmComment <line1>,<line2>call CmmComment()
"================================
let g:CmmDict={
        \ 'vim':'" ',
        \ 'c':'\/\/ ',   'cpp':'\/\/ ',
        \ 'conf':'# ',   'make':'# '  , 'sh':'# ', 'python':'# ',
        \ 'dosini':'; ', 'autohotkey':'; ',
        \ }
function! CmmComment()
    let Tmm=has_key(g:CmmDict, &filetype) ? get(g:CmmDict,&filetype) : ''
    if Tmm != ''
        let line=getline(".")
        if  line=~ '^'.Tmm.'.*'
            let repl = substitute(line, '^'.Tmm, "", "g")
            call setline(".", repl)
        else
            let repl = substitute(line, '^', Tmm, "g")
            call setline(".", repl)
        endif
    else
        echo "comment sign not yet set for *." . &filetype
    endif
endfunction
