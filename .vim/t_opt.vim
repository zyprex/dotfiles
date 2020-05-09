" highlight
" hi Normal ctermbg=Black
" let loaded_matchparen = 1
" hi MatchParen ctermbg=black ctermfg=grey  guibg=grey guifg=black
" hi Visual cterm=reverse
" options
set hidden
set termencoding=utf-8 encoding=utf-8 fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set background=dark
set foldmethod=syntax nofoldenable
set number relativenumber
set browsedir=buffer autochdir
set wrap linebreak breakindent showbreak=↔
" au FileType text,markdown,html,xml set wrap
" au FileType c,cpp,python,vim set textwidth=80 "gq
" set colorcolumn=81
set smartindent tabstop=4 shiftwidth=4 expandtab
set cmdheight=1
set laststatus=2
set textwidth=0
set showcmd showmatch matchtime=1 noshowmode
set hlsearch incsearch ignorecase smartcase
set gdefault " for :s/../../g
set mousehide mouse=a
set backspace=2
set scrolloff=99 display=lastline
set history=9999
set noswapfile
" set autosave
set wildmenu wildmode=full
" complete
set define="^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)"
set complete=.,w,b,u ",t,i,d
set completeopt=menuone,noselect ",preview
set pumheight=5 pumwidth=0
set completepopup=height:10,width:10,align:menu,border:on,highlight:IncSearch
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

if has('python3') | set pyxversion=3 | endif
set shortmess=flnxtToOcF
" set binary noeol
set ttyfast ttyscroll=3
set modeline modelines=4
set exrc secure
set nostartofline
set title
" hi! User1 term=inverse,bold cterm=inverse,bold ctermfg=red guibg=red
set statusline=%q%f\ [%1*%M%*%n%R%W]
set statusline+=%=%{&ff}.%\{toupper(&fenc)\}.%Y%5l\ Ξ\ %2c  
" disable insert comment automatically
au FileType * setlocal formatoptions-=cro
set list listchars=tab:»\ ,trail:·,nbsp:_,precedes:<,extends:>

