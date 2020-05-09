" ----------------------------------------
" Name: SingleCompile, SingleRun
" Description: Complie & Run single file
" Requires: AsyncRun
" Type: function
" ----------------------------------------
if has('win32') || has('win64')"{{{

let s:cache_path = $VIM.'\.cache\cout.exe'

let s:c_com_parm = 'gcc % -o '.s:cache_path
let s:cp_com_parm = 'g++ % -o '.s:cache_path
let s:sh_com_parm = '%'
let s:py_com_parm = 'python %'

let s:c_exe_parm = s:cache_path
let s:cp_exe_parm = s:cache_path
let s:sh_exe_parm = '%'
let s:py_exe_parm = 'python %'

elseif  has('win32unix')

let s:c_com_parm = ' gcc % '
let s:cp_com_parm = ' g++ % '
let s:sh_com_parm = ' bash ./%'
let s:py_com_parm = ' python %'

let s:c_exe_parm = ' ./a.exe'
let s:cp_exe_parm = ' ./a.exe'
let s:sh_exe_parm = ' ./%'
let s:py_exe_parm = ' python %'

elseif has('unix') || has('linux')

let s:c_com_parm = ' gcc % -Wall -lm -lpthread '
let s:cp_com_parm = ' g++ % '
let s:sh_com_parm = ' ./%'
let s:py_com_parm = ' python %'

let s:c_exe_parm = './a.out'
let s:cp_exe_parm = './a.out'
let s:sh_exe_parm = './%'
let s:py_exe_parm = ' python %'

endif

function SingleCompile(flags)
    exec 'w'
	if &filetype == 'c'          | exec a:flags s:c_com_parm
    elseif &filetype == 'cpp'    | exec a:flags s:cp_com_parm
    elseif &filetype == 'sh'     | exec a:flags s:sh_com_parm
    elseif &filetype == 'python' && a:flags == 'AsyncRun'
                exec a:flags "-raw" s:py_com_parm
    elseif &filetype == 'python' | exec a:flags s:py_com_parm
    endif
endfunction

function SingleRun(flags)
	if &filetype == 'c'          | exec a:flags s:c_exe_parm
    elseif &filetype == 'cpp'    | exec a:flags s:cp_exe_parm
    elseif &filetype == 'sh'     | exec a:flags s:sh_exe_parm
    elseif &filetype == 'python' && a:flags == 'AsyncRun'
                exec a:flags "-raw" s:py_com_parm
    elseif &filetype == 'python' | exec a:flags s:py_exe_parm
	endif
endfunction"}}}
" ----------------------------------------
" Name: CmmComment
" Description: quick comment
" Requires:
" Type: function
" ----------------------------------------
function CmmComment()"{{{
    let Tmm=has_key(g:CmmDict, &filetype) ? get(g:CmmDict,&filetype) : ''
    if Tmm != ''
        let line=getline(".")
        if line=~ '^'.Tmm.'.*'
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
let g:CmmDict={ 'vim':'" ', 'c':'\/\/ ', 'cpp':'\/\/ ',
        \ 'conf':'# ',   'make':'# '  , 'sh':'# ', 'python':'# ',
        \ 'dosini':'; ', 'autohotkey':'; ',
        \ 'dosbatch':':: ',
        \ }"}}}
" ----------------------------------------
" Name: FileTypeConf
" Description: open buffer ftplugin dir
" Requires:
" Type: function
" ----------------------------------------
function FileTypeConf()"{{{
    call mkdir($HOME.'/.vim/ftplugin/'.&filetype,"p")
    exec 'Sexplore ' $HOME . '/.vim/ftplugin/' . &filetype
endfunction"}}}
" ----------------------------------------
" Name: BDOHconverter
" Description: convert between
" binary octonary decimal hexadecimal
" Requires:
" Type: function
" ----------------------------------------
"10 8 120 98
function BDOHconverter(base)"{{{
    let save_cursor = getcurpos()
    let cw = expand('<cword>')
    if cw =~? '\X[^0xX]\X' | return | endif   " match regex and ignore case
"     echo printf(" %s --> %#b %#o %d %#x",cw,cw,cw,cw,cw)
    if a:base ==? 'x'
        exec 's/'.cw.'/\=printf("%#x",submatch(0))/g'
    elseif a:base ==? 'd'
        exec 's/'.cw.'/\=printf("%d",submatch(0))/g'
    elseif a:base ==? 'o'
        exec 's/'.cw.'/\=printf("%#o",submatch(0))/g'
    elseif a:base ==? 'b'
        exec 's/'.cw.'/\=printf("%#010b",submatch(0))/g'
    endif
    call setpos('.', save_cursor)
endfunction"}}}
" ----------------------------------------
" Name: FosterCompl
" Description: user complete function
" Requires:
" Type: function, command, autocmd
" ----------------------------------------
let g:foster_list = []"{{{
fun! FosterCompl(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\S'
      let start -= 1
    endwhile
    return start
  else
    let res = []
    for m in g:foster_list
      if m =~ '^' . a:base
    call add(res, m)
      endif
    endfor
    return res
  endif
endfun
set completefunc=FosterCompl

command! -nargs=+ FosterComplAdd call writefile(['<args>'],$HOME.'/.vim/ftplugin/'.&filetype.'/foster.list',"a")
" user complete file add
autocmd! BufEnter *
        \ let g:foster_list =
        \ file_readable($HOME.'/.vim/ftplugin/'.&filetype.'/foster.list') ?
        \ readfile($HOME.'/.vim/ftplugin/'.&filetype.'/foster.list') :
        \ readfile($HOME.'/.vim/ftplugin/_common/foster.list')"}}}
" ----------------------------------------
" Name: ZeroLine
" Description: add header line
" Requires:
" Type: function, autocmd
" ----------------------------------------
function ZeroLine()"{{{
  " shell
  if &filetype == 'sh' && has('linux')
    call setline(1, "\#!/bin/bash")
  endif
  " python
  if &filetype == 'python' && has('linux')
    call setline(1, "\#!/usr/bin/env python")
    call append(1, "\# coding: utf-8")
  elseif &filetype == 'python' " && has('win32')
    call setline(1, "\# -*- coding: utf-8 -*-")
  endif
  " next line
  normal Go
endfunction
"}}}
" ----------------------------------------
" Name: GenerateHeaderFile, GetFirstCommentBlock
" Description: Generate Header File
" Requires:
" Type: function, command
" ----------------------------------------
function GenerateHeaderFile()"{{{
  if &filetype != "c"
    echo "Sorry, this command only support c files!" | return
  endif
  let hfname=expand("%<").".h"
  let alli=[]
  let cblist=[]
  if filereadable(hfname)
    let cblist=GetFirstCommentBlock(hfname)
  endif
  if getline(1)!="#include \"".hfname."\""
    call append(0, "#include \"".hfname."\"")
  endif
  if filereadable(hfname)
    echo hfname." file already exist, update(y/n)?"
    let answer=getchar()
    if nr2char(answer)==?'y'
      call delete(hfname)
      redraw
    else
      redraw | echo "abort!" | return
    endif
  endif
  let onceHeader="_".toupper(expand('%<'))."_H_"
  let alli+=["#ifndef ".onceHeader]
  let alli+=["#define ".onceHeader]
  let alli+=cblist
  let lineN=line('$')
  let lineA=0
  while lineA<=lineN
    let lineS=getline(lineA)
	let funD=matchstr(lineS, "^[a-zA-Z].*\)")
    if funD != ""
        let alli+=[funD.";"]
    endif
    let lineA = lineA + 1
  endwhile
  let alli+=["#endif"]
  call writefile(alli,hfname)
  echo "Header File Generated."
endfunction

function! GetFirstCommentBlock(fname)
  let lstop=0
  let cblist=[]
  for line in readfile(a:fname)
    if line =~ '^/.*' | let lstop=lstop+1 | endif
    if lstop == 1 | let cblist+=[line]
    elseif lstop == 2 | let cblist+=[line] | break | endif
  endfor
  return cblist
endfunction
command GenerateHeaderFile call GenerateHeaderFile()
"}}}
" ----------------------------------------
" Name: ImmersiveMode
" Description: switch immersive mode
" Requires:
" Type: function
" ----------------------------------------
function ImmersiveMode()"{{{
    if &laststatus==2 && &showtabline==1
        set ls=0 stal=1 nu nornu ruler
    elseif &laststatus==0 && &showtabline==1
        set ls=0 stal=0 nonu nornu ruler
    elseif &laststatus==0 && &showtabline==0
        set ls=2 stal=1 nu rnu noruler
    endif
endfunction"}}}
" ----------------------------------------
" Name: AutoPages,AutoPageDo
" Description: auto reader
" Requires:
" Type: function
" ----------------------------------------
let g:auto_page_latch=1"{{{

function AutoPages(wait_ms)
    if !has("timers") | return | endif
    let g:auto_page_latch=g:auto_page_latch==0?1:0
    set guicursor+=n:hor15-blinkon0
    call timer_start(a:wait_ms, 'AutoPageDo',{'repeat':-1})
endfunction

func AutoPageDo(ap_timer_id)
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
endfunc"}}}
" ----------------------------------------
" Name: ExternalRun
" Description: run path out of vim
" Requires:
" Type: function
" ----------------------------------------
" nnoremap <leader>! :call ExternalRun()<cr>
function! ExternalRun()"{{{
    if has("win32")
        let fpath = expand('<cfile>')
        if  fpath =~? '.*\.\(jpg\|png\)'
          !start <cfile>
        else | echo | endif | redraw
    endif
endfunction"}}}
" ----------------------------------------
" Name: GetVisualSelection
" Description: get visually selected text
" Requires:
" Type: function
" ----------------------------------------
function GetVisualSelection()"{{{
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0 | return '' | endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction"}}}
" ----------------------------------------
" Name: SurroundOnion
" Description: surrounds punct
" Requires:
" Type: function,v-mode keymap
" ----------------------------------------
"{{{
vnoremap + <Esc>:call SurroundOnion()<cr>
function SurroundOnion()
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
nnoremap +} i{<esc>$a}<esc>"}}}
" ----------------------------------------
" Name: MiscellanousMenu ...
" Description: some misc use ...
" Requires:
" Type: function
" ----------------------------------------
function MiscellanousMenu()"{{{
    let l:misc_dict = {
            \ ' [R] ' : 'rename current buffer',
            \ ' [S] ' : 'remove trailing space',
            \ ' [a] ' : 'tail strings N line below',
            \ ' [b] ' : 'scroll (un)bind to alternate windows',
            \ ' [c] ' : '<cword> format converter',
            \ ' [l] ' : 'lvimgrep and lopen',
            \ ' [s] ' : 'scrolloff 0 or 99',
            \ ' [r] ' : 'current line simple replace',
            \}
    let l:newline=0
    for wininf in getwininfo() | let max_width = wininf.width | endfor
	for key in sort(keys(l:misc_dict))
        echohl Include | echon key
        let l:newline = l:newline==0 ? 1 : 0
        if newline
            echohl MoreMsg | echon printf("%-".max_width/2."s",l:misc_dict[key])
        else
            echohl MoreMsg | echon l:misc_dict[key] "\n"
        endif
    endfor
    call MiscMenu()
endfunction

function MiscMenu()
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
endfunction"}}}
" ----------------------------------------
" Name:  Poems
" Description: Random Poems
" Requires: webapi
" Type: function
" ----------------------------------------
func! Poems()
    let res = webapi#http#get('https://v1.jinrishici.com/all.json')
    let obj = webapi#json#decode(res.content)
    return obj.content
endfunc

func! TransLang(qword,which)
"     if  a:which = 'youdao'
"         let res = webapi#http#get('http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i='.a:qword)
"         let obj = webapi#json#decode(res.content)
"         echo obj.translateResult[0][0].tgt
"     else if a:which = 'iciba'
"         let res = webapi#http#get('http://open.iciba.com/huaci_v3/dict.php?word=word')  " .a:qword)
"         echo res.content
"     endif
endfunc


" ----------------------------------------
" Name:  CFormat
" Description: format c code
" Requires:
" Type: function
" ----------------------------------------
func! CFormat()
    let line = getline(".") 
    let repl = substitute(line, '(' , '( ', "g")
    let repl = substitute(repl, ')' , ' )', "g")
    let repl = substitute(repl, ',' , ', ', "g")
    let repl = substitute(repl, '=' , ' = ', "g")
    let repl = substitute(repl, '+' , ' + ', "g")
    let repl = substitute(repl, '-' , ' - ', "g")
    let repl = substitute(repl, '*' , ' * ', "g")
    let repl = substitute(repl, '/' , ' / ', "g")
    let repl = substitute(repl, '&&' , ' && ', "g")
    let repl = substitute(repl, '||' , ' || ', "g")
    call setline(".", repl)
endfunc

 " vim: fen fdm=marker fen tw=85
