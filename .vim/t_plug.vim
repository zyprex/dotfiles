" plugins tweak:
call plug#begin($HOME.'/.vim/plug')

" COMPLETE:
" Use release branch (Recommend)
if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = ['coc-ccls']
"     autocmd FileType python let b:coc_enabled= 0
"     autocmd FileType python let b:coc_suggest_disable = 1
    let g:coc_start_at_startup=0
endif
Plug 'vim-scripts/OmniCppComplete'
let OmniCpp_ShowScopeInAbbr = 1
let OmniCpp_ShowPrototypeInAbbr= 1
let OmniCpp_MayCompleteScope = 1
Plug 'lifepillar/vim-mucomplete'
set noinfercase
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 500
let g:mucomplete#cycle_all = 1
let g:mucomplete#empty_text = 0
let g:mucomplete#empty_text_auto = 1
let g:mucomplete#look_behind = 12
let g:mucomplete#reopen_immediately = 0
let g:mucomplete#chains = {
    \ 'default' : ['user',  'c-p', 'path', 'file' ],
    \ 'vim'     : ['user',  'c-p',  'cmd', 'path', 'file' ],
    \ 'c'       : ['user',  'c-p', 'line', 'omni', 'path' ],
    \ 'cpp'     : ['user',  'c-p', 'line', 'omni', 'path' ],
    \ 'python'  : ['omni',  'c-p', 'user', 'line', 'path' ],
\}


" FINDER:
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
if has('python3')
    if has('win32') || has('win64')
        Plug 'Yggdroot/LeaderF' , { 'do': './install.bat' }
    elseif has('unix') || has('linux')
        Plug 'Yggdroot/LeaderF' , { 'do': './install.sh' }
    endif
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    nnoremap <leader>l :LeaderfLine<cr>
    nnoremap <leader>t :LeaderfBufTag<cr>
    nnoremap <leader>m :LeaderfMru<cr>
    nnoremap <leader>* :LeaderfSelf<cr>
    let g:Lf_IndexTimeLimit=45
    let g:Lf_ShowRelativePath=0
    let g:Lf_ShowHidden=1
    let g:Lf_WindowHeight=0.3
    let g:Lf_DelimiterChar=';'
    let g:Lf_DefaultMode='NameOnly'
    let g:Lf_WildIgnore = {
        \ 'dir': [],
        \ 'file': ['*.swp','*.exe','*.out']
        \}
    let g:Lf_CursorBlink=0
    let g:Lf_StlColorscheme = 'powerline'
endif
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_match_window = 'bottom,order:btt,min:5,max:5,results:5'
    let g:ctrlp_max_depth = 10
    let g:ctrlp_lazy_update = 1
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_use_caching = 1
    let g:ctrlp_clear_cache_on_exit = 0 " do not clear cache, use <F5>
    nnoremap <C-p>f :CtrlPCurFile<cr>
    nnoremap <C-p>b :CtrlPBuffer<cr>
    nnoremap <C-p>l :CtrlPLine<cr>
    nnoremap <C-p>t :CtrlPBufTag<cr>
    nnoremap <C-p>m :CtrlPMRU<cr>
    nnoremap <C-p>* :CtrlPMixed<cr>
    let g:ctrlp_extensions = ['buffertag', 'quickfix', 'rtscript'] " using <c-f>, <c-b> Loop extensions

" SNIPPETS:
Plug 'drmingdrmer/xptemplate'
    let g:xptemplate_vars="$author=zyprex"
    let g:xptemplate_nav_next = '<C-j>'
    let g:xptemplate_nav_prev = '<C-k>'
    let g:xptemplate_fallback = '<C-x><C-u>'
    let g:xptemplate_nav_cancel = '<Cr>'

" INTERFACE:
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'

" DEBUG:
Plug 'skywind3000/asyncrun.vim' " asynchronous feature require Vim8
    let g:asyncrun_mode = 0
    let g:asyncrun_encs = 'gbk'
    let g:asyncrun_open = 6
    let g:asyncrun_wrapper = ''
    let g:asyncrun_save	= 1
    nnoremap <silent> <F12> :call asyncrun#quickfix_toggle(5)<cr>
    let $PYTHONUNBUFFERED=1
Plug 'vim-syntastic/syntastic'
    let g:syntastic_mode_map = { "mode" : "passive" }
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_loc_list_height = 0
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
" include all curernt path
autocmd BufEnter *.c
    \    let g:syntastic_c_include_dirs = split(&path, ',')
autocmd BufEnter *.cpp
    \    let g:syntastic_cpp_include_dirs = split(&path, ',')

" MISC:
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
    nnoremap <F3> :Tagbar<cr>
Plug 'justinmk/vim-sneak'
    " 2-character Sneak (default)
    nmap ss <Plug>Sneak_s
    nmap SS <Plug>Sneak_S
    " visual-mode
    xmap ss <Plug>Sneak_s
    xmap SS <Plug>Sneak_S
    " operator-pending-mode
    omap ss <Plug>Sneak_s
    omap SS <Plug>Sneak_S

    " 1-character enhanced 'f'
    nmap f <Plug>Sneak_f
    nmap F <Plug>Sneak_F
    " visual-mode
    xmap f <Plug>Sneak_f
    xmap F <Plug>Sneak_F
    " operator-pending-mode
    omap f <Plug>Sneak_f
    omap F <Plug>Sneak_F

    " 1-character enhanced 't'
    nmap t <Plug>Sneak_t
    nmap T <Plug>Sneak_T
    " visual-mode
    xmap t <Plug>Sneak_t
    xmap T <Plug>Sneak_T
    " operator-pending-mode
    omap t <Plug>Sneak_t
    omap T <Plug>Sneak_T
    let g:sneak#prompt = '>'
Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'
Plug 'mattn/webapi-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-unimpaired'

" FILETYPLE:
" Plug 'sheerun/vim-polyglot'
Plug 'davidhalter/jedi-vim', {'for':'python'}
"     let g:jedi#auto_initialization = 0
" COLORSCHEMES:
Plug 'flazz/vim-colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()
"""""""""""""""""""" NETRW: *netrw-browse-maps*
let g:netrw_banner=0
let g:netrw_liststyle = 2
let g:netrw_list_hide= '.*\.swp$'
let g:netrw_sort_by = "exten"
let g:netrw_sizestyle = "H"
" let g:netrw_winsize = 20
let g:netrw_special_syntax = 1
nnoremap <F2> :Sexplore<cr>

" \\\\\\\\\\\\\\\\ beta \\\\\\\\\\\\\\\\\
inoremap<silent> <C-x><C-x> <esc>:let b:ft_cc= g:mucomplete#chains[&filetype]<bar>
            \ call add(b:ft_cc,b:ft_cc[0])<bar>call remove(b:ft_cc,0)<bar>
            \ let g:mucomplete#chains[&filetype] = b:ft_cc<bar>
            \ echo g:mucomplete#chains[&filetype]<cr>i
