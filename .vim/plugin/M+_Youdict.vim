nnoremap g? :call YouDictTrans(expand('<cword>'))<cr>
vnoremap g? :call YouDictTrans(GetVisualSelection())<cr>
command! -nargs=1 YDict call YouDictTrans('<args>')
"===============================
function YouDictTrans(word)
let res = webapi#http#get('https://www.youdict.com/w/'.a:word)
" ----------------------------for meaning
if matchstr(res.content, '对不起，没有查询到这个单词') != ''
  echo "对不起，没有查询到这个单词"
  return
endif

let mestr = matchstr(res.content, '<div class="row" id="yd-word-meaning"><ul>.*<\/ul><\/div>')
let mestr = substitute(mestr, '<div class="row" id="yd-word-meaning"><ul>\n\|\n<\/ul><\/div>', "", "g")
let mestr = substitute(mestr, '<li>\|<\/li>', "", "g")
echo mestr

" space continue
if getchar() != 32|redraw|return|endif
" ----------------------------for Etymologically
let chstr = matchstr(res.content, '<p>.*</p></div>')
if chstr != ''
  echo "-------------------------中文词源\n".substitute(chstr, '<p>\|<\/p><\/div>', "", "g")
endif

" space continue
if getchar() != 32|redraw|return|endif
" ----------------------------for sample sentence
let samstr = matchstr(res.content,
      \ '<div class="row" id="yd-liju">.*</dl>                 <dl><p>[')
let samstr = substitute(samstr, 
      \ '<div class="row" id="yd-liju">\|</dl>                 <dl><p>[',
      \ "", "g")
let samstr = substitute(samstr, 
      \ '                 <dl><dt>\|<dl><dt>', "", "g")
let samstr = substitute(samstr, '<\/dl>\|<\/dt>', "\n", "g")
let samstr = substitute(samstr, '<b>\|<\/b>\|<dd>\|<\/dd>', "", "g")
let samstr = substitute(samstr, '<p>', "[", "g")
let samstr = substitute(samstr, '<\/p>', "]", "g")

if samstr != ''
  echo "-------------------------词典例句".samstr
endif
if getchar() |redraw|return|endif
endfunction
