" interface for vim
" startify >>>>>
let g:ascii_front = [ getcwd(),strftime("%Y %b.%d %a %H:%M:%S")]
let g:startify_custom_header =
    \ 'startify#pad(g:ascii_front)'
let g:startify_custom_footer = ['(c) Copyright 2020 ZhouYu. All Rights Reserved.']
let g:startify_skiplist=['^.*\\lavanic\\emag.*']
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'commands',  'header': ['   Commands']       },
\ ]

" lightline >>>>>
let g:lightline = { 'enable' : {'statusline': 1, 'tabline': 1} }
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'close' ] ] }
let g:lightline.tab = {
    \ 'active': [ 'tabnum', 'filename', 'modified' ],
    \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
let g:lightline = {
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ],
    \              [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo', 'syntastic' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ] ,
    \ },
    \ 'inactive': {
    \   'left':   [ [ 'filename' ] ],
    \   'right':  [ [ 'lineinfo' ],
    \             [ 'percent' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
\ }
" let g:lightline.component_function_visible_condition = {}

let g:lightline.tabline_separator = { 'left': '', 'right': '' }
let g:lightline.tabline_subseparator = { 'left': '┃', 'right': '┃' }
" solarized selenized_dark one nord
if has('win32') || has('win64')
    let g:lightline.separator = {'left':'┇','right':'┇'}
    let g:lightline.subseparator = {'left':'╲','right':'╲'}
"     let g:lightline.subseparator = {'left':'\\','right':'\\'}
    let g:lightline.colorscheme = 'srcery_drk_dim'
elseif has('win32unix')
    let g:lightline.separator = {'left':'','right':''}
    let g:lightline.subseparator = {'left':'❯','right':'❮'}
    let g:lightline.colorscheme = 'material'
elseif has('unix') || has('linux')
    let g:lightline.separator = {'left':'┇','right':'┇'}
    let g:lightline.subseparator = {'left':'╱','right':'╱'}
"     let g:lightline.subseparator = {'left':'/','right':'/'}
    let g:lightline.colorscheme = 'darcula'
endif

"     let g:lightline.colorscheme = 'deepspace'

" test : digraphs
" ╱ ╲ ◢ ◣ │ ┃ ▌▐ ⋮ ┆ ┇ ▀ ▄ 〓 ◆ ▬ ▓▒░ ╱ ╲ ▶ ◀ ❯ ❮ ⁞ : ‖ ⌠ ⌡
" let g:lightline.separator = {'left':'◣','right':'◢'}

let g:lightline.mode_map = {
    \ 'n' : 'N',
    \ 'i' : 'I',
    \ 'R' : 'R',
    \ 'v' : 'V',
    \ 'V' : 'V-L',
    \ "\<C-v>": 'V-B',
    \ 'c' : 'C',
    \ 's' : 'S',
    \ 'S' : 'S-L',
    \ "\<C-s>": 'S-B',
    \ 't': 'Terminal',
    \ }


" colorschemes >>>>>
if has('gui_running')
    if has('win32') || has('win64')
"         colorscheme Atelier_EstuaryDark
        colorscheme mushroom_mod2
    elseif has('unix') || has('linux')
        colorscheme Monokai
    endif
else
    set t_Co=256
    if has('win32') || has('win64')
        colorscheme fx
    elseif has('unix') || has('linux')
        colorscheme gruvbox
    endif
endif

colorscheme mushroom_mod2
" syntax on
" COLOR LIST --------------
" ---Rank C
" mango soruby vydark hilal desert darth neon busybee candypaper ego alduin
" ---Rank B
" distinguished darkZ hemisu lizard flatcolor eva eva01 eva01-LCL sierra brogrammer fx distll luna tender codedark ayu moody thermopylae archery deus phd ecostation dracula tayra monochrome zenburn
" ---Rank A
" vilight inkpot solarized molokai last256 apperntice sorcerer fu abra coffee greenvision mushroom heroku wombat papercolor cabin sourcerer deep-space unicon dzo hybrid_material boa breezy stormpetrel fight-in-the-shade Atelier_CaveDark Atelier_EstuaryDark gotham256 bubblegum Spink OceanicNext putty basic-dark base16-ateliercave badwolf jellybeans hybrid twilight256 gruvbox
" ----Rank S
" cosmic_latte
" ////////////////// beta /////////////////////

hi! Sneak guifg=White guibg=#434343 ctermfg=black ctermbg=171
hi! SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
