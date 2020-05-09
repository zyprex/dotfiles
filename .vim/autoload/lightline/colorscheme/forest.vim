" =============================================================================
" Filename: autoload/lightline/colorscheme/forest.vim
" Author: zyprex
" License: MIT License
" Last Change: 2020 Feb.15 Sat 15:51:00
" =============================================================================

" color name
let s:blue = ['#546e7a',255]
let s:green = ['#689f38',255]
let s:red = ['#f44336',255]
let s:yellow = ['#ffff33',255]
let s:bluegrey = ['#78909c',255]
let s:grey =['#757575', 255]
let s:orange = ['#f57c00',255] 

" hi! Normal guifg= #f1c40f guibg=#f57c00
let s:nl_fg = ['#000000',255]
let s:nl_bg = s:bluegrey
let s:nl_fg2 = ['#000000',255]
let s:nl_bg2 = ['#616161',255]
let s:nm_fg = ['#000000',255] 
let s:nm_bg = ['#424242',255] 
let s:nr_fg = ['#000000',55]
let s:nr_bg = s:nl_bg
let s:nr_fg2 = ['#000000',55]
let s:nr_bg2 = ['#616161',55]

let s:xl_fg = ['#555555',55]
let s:xl_bg = ['#343434',55]
let s:xl_fg2 = ['#555555',55]
let s:xl_bg2 = ['#343434',55]
let s:xm_fg = ['#555555',55]
let s:xm_bg = ['#343434',55]
let s:xr_fg = ['#555555',55]
let s:xr_bg = ['#343434',55]
let s:xr_fg2 = ['#555555',55]
let s:xr_bg2 = ['#343434',55]

let s:il_fg = ['#000000',255]
let s:il_bg = s:green
let s:il_fg2 = s:nl_fg2
let s:il_bg2 = s:nl_bg2

let s:rl_fg = ['#000000',255]
let s:rl_bg = s:red
let s:rl_fg2 = s:nl_fg2
let s:rl_bg2 = s:nl_bg2

let s:vl_fg = ['#000000',255]
let s:vl_bg = s:orange
let s:vl_fg2 = s:nl_fg2
let s:vl_bg2 = s:nl_bg2

let s:tabl_fg = ['#000000', 255]
let s:tabl_bg = ['#444444', 255]
let s:tabs_fg = ['#A0A0A0', 255]
let s:tabs_bg = ['#343434', 255]
let s:tabm_fg = ['#000000', 255]
let s:tabm_bg = ['#444444', 255]
let s:tabr_fg = ['#000000', 255]
let s:tabr_bg = ['#444444', 255]

let s:err_fg = ['#FF0000',255] 
let s:err_bg = ['#000000',255] 
let s:warn_fg = ['#FFFF00',255] 
let s:warn_bg = ['#000000',255] 

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:nl_fg, s:nl_bg], [ s:nl_fg2, s:nl_bg2 ] ]
let s:p.normal.right = [ [ s:nr_fg, s:nr_bg], [ s:nr_fg2, s:nr_bg2 ] ]
let s:p.inactive.right = [ [ s:xr_fg, s:xr_bg], [ s:xr_fg2, s:xr_bg2] ]
let s:p.inactive.left =  [ [ s:xl_fg, s:xl_bg], [ s:xl_fg2, s:xl_bg2] ]
let s:p.insert.left = [ [ s:il_fg, s:il_bg], [ s:il_fg2, s:il_bg2] ]
let s:p.insert.right = [ [ s:il_fg, s:il_bg], [ s:il_fg2, s:il_bg2] ]
let s:p.replace.left = [ [ s:rl_fg, s:rl_bg], [ s:rl_fg2, s:rl_bg2] ]
let s:p.replace.right = [ [ s:rl_fg, s:rl_bg], [ s:rl_fg2, s:rl_bg2] ]
let s:p.visual.left = [ [ s:vl_fg, s:vl_bg], [ s:vl_fg2, s:vl_bg2] ]
let s:p.visual.right = [ [ s:vl_fg, s:vl_bg], [ s:vl_fg2, s:vl_bg2] ]
let s:p.normal.middle = [ [ s:nm_fg, s:nm_bg ] ]
let s:p.inactive.middle = [ [ s:xm_fg, s:xm_bg] ]
let s:p.tabline.left = [ [ s:tabl_fg, s:tabr_bg] ]
let s:p.tabline.tabsel = [ [ s:tabs_fg, s:tabs_bg ] ]
let s:p.tabline.middle = [ [ s:tabm_fg, s:tabm_bg] ]
let s:p.tabline.right = copy(s:p.tabline.left)
let s:p.normal.error = [ [ s:err_fg, s:err_bg] ]
let s:p.normal.warning = [ [ s:warn_fg, s:warn_bg ] ]

let g:lightline#colorscheme#forest#palette = lightline#colorscheme#flatten(s:p)


" call lightline#enable()
" call lightline#disable()
