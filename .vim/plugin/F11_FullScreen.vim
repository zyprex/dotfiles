" F11 switch immersive mode, ls laststatus stal showtabline
nnoremap <silent> <F11>
      \ :
      \ if &laststatus==2 && &showtabline==1<bar>
      \      set ls=0 stal=1 nu nornu ruler<bar>
      \ elseif &laststatus==0 && &showtabline==1<bar>
      \      set ls=0 stal=0 nonu nornu ruler<bar>
      \ elseif &laststatus==0 && &showtabline==0<bar>
      \      set ls=2 stal=1 nu rnu noruler<bar>
      \ endif<cr>
