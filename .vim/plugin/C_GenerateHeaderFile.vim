" Generate Header File
command! GenerateHeaderFile call GenerateHeaderFile()
function! GenerateHeaderFile()
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
