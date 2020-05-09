" MiscellanousMenu
let g:list_q_opt={
            \ ' [R] ' : 'rename current buffer',
            \ ' [S] ' : 'remove trailing space',
            \ ' [a] ' : 'tail strings N line below',
            \ ' [b] ' : 'scroll (un)bind to alternate windows',
            \ ' [c] ' : '<cword> format converter',
            \ ' [l] ' : 'lvimgrep and lopen',
            \ ' [s] ' : 'scrolloff 0 or 99',
            \ ' [r] ' : 'current line simple replace',
            \}

function! MiscellanousMenu(Misc_dict, Group_No)
    let l:newline=0
    for wininf in getwininfo() | let max_width = wininf.width | endfor
	for key in sort(keys(a:Misc_dict))
        echohl Include | echon key
        let l:newline = l:newline==0 ? 1 : 0
        if newline
            echohl MoreMsg | echon printf("%-".max_width/2."s",a:Misc_dict[key])
        else
            echohl MoreMsg | echon a:Misc_dict[key] "\n"
        endif
    endfor
    if a:Group_No==1 | call MiscMenuG1() | endif
endfunction

function! MiscMenuG1()
let one_chr = nr2char(getchar()) | redraw!
if one_chr==#"b"
    exec "normal \<c-w>p:set scrollbind!\<cr>
                \\<c-w>p:set scrollbind!\<cr>
                \:echohl MoreMsg | echo \"scrollbind \" &scrollbind\<cr>"
elseif one_chr==#"s"
    if &scrolloff==99 | set scrolloff=0 | else | set scrolloff=99 | endif
    echohl MoreMsg | echo "scrolloff " &scrolloff
elseif one_chr==#"a"
    let l:append_lstr=input("+{lnum} {strings}:")
    if l:append_lstr != ""
        exec ".,+".printf("%d",l:append_lstr)
                    \."normal A".l:append_lstr[stridx(l:append_lstr," ")+1:]
        echohl MoreMsg | echo "+" printf("%d",l:append_lstr)
                    \ " line " l:append_lstr[stridx(l:append_lstr," ")+1:]
    endif
elseif one_chr==#"l"
    let l:loc_vimgrep=input("lvimgrep {pattern} {file}:")
    if l:loc_vimgrep != ""
        exec "lv " l:loc_vimgrep
        lopen
    endif
elseif one_chr==#"c"
    let l:fmt_chr=input(expand('<cword>')
                       \."->%{[flags][field-width][.precision]type}:")
    if l:fmt_chr != ""
        exec 's/'.expand('<cword>')
                \.'/\=printf("%'.l:fmt_chr.'",submatch(0))/g'
    endif
elseif one_chr==#"r"
   exec 's/'.input("old/new:").'/g'
elseif one_chr==#"R"
    let l:newbufname=input("new name:")
    if l:newbufname!=""
        call rename(expand("%"),l:newbufname)
        e l:newbufname
    endif
elseif one_chr==#"S"
    let save_cursor = getcurpos()
    %s/\s\+$//e
    call setpos('.', save_cursor)
endif
echohl None
endfunction
