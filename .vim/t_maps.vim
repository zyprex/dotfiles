" normal use
" autocmd! BufWritePost $MYVIMRC source $MYVIMRC
nnoremap <leader>e :vs $MYVIMRC<cr>
nnoremap <leader>v :source $MYVIMRC <bar> source $MYGVIMRC<cr>
nnoremap <leader>w :w<cr>
nnoremap \ :noh<bar>redraw!<cr>
" windows action hjkltbHJKLTB-+=<>_|rwpnocvs
nmap <space> <c-w>
" copy&paste
" usage <leader>y{motion}
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy
vnoremap <leader>y "+y
nnoremap <leader>p :set paste<cr>"+p:set nopaste<cr>
nnoremap <leader>P :set paste<cr>"+P:set nopaste<cr>
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" append to clipboard reg
vnoremap Sy y:let @+ .= @0<cr> 
" simulate terminal
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" always enter improved Ex-mode
nnoremap Q gQ
" always enter virtual Replace-mode
nnoremap r gr
nnoremap R gR

if has("gui_running")
    nnoremap<silent> <F1> :if &go =~? "!"<bar>
                \    set go-=!<bar>echon "guioptions - !"<bar>
                \ else<bar>
                \    set go+=!<bar>echon "guioptions + !"<bar>
                \ endif<cr>
	nnoremap <F4> :set guifont=<c-r>=&guifont<cr>
endif

" nnoremap <F5> :%s/\s\+$//e<cr>
nnoremap <F6> :call AutoPages(20)<cr>
" add-on ctags
nnoremap <F7> :call RunShell("Generate tags",
            \ "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")<cr>
" quick add ftplugin file
nnoremap <F8> :call FileTypeConf()<cr>
" single file  complie and run
nnoremap <F9> :call SingleCompile("!")<cr>
nnoremap <F10> :call SingleRun("!")<cr>
nnoremap <leader><F9> :call SingleCompile("AsyncRun")<cr>
nnoremap <leader><F10> :call SingleRun("AsyncRun")<cr>

nnoremap<silent> <F11> :call ImmersiveMode()<cr>
" tags quick browser
" nnoremap <leader>] :ptag <c-r><c-w><cr>
" nnoremap <leader>n :ptnext<cr>
" nnoremap <leader>p :ptprevious<cr>

nnoremap <space>m :call CmmComment()<cr>
vnoremap <space>m :call CmmComment()<cr>
command -range CmmComment <line1>,<line2>call CmmComment()
" 0x47
nnoremap gxx :call BDOHconverter('x')<cr>
nnoremap gxd :call BDOHconverter('d')<cr>
nnoremap gxo :call BDOHconverter('o')<cr>
nnoremap gxb :call BDOHconverter('b')<cr>
" v-mode text
if has("win32")
vnoremap <silent> ?/ <Esc>:exec "/".GetVisualSelection()<cr>
vnoremap <silent> ?! <Esc>:exec "!start ".GetVisualSelection()<cr>
vnoremap <silent> ?? <Esc>:exec "!start https://www.sogou.com/web?query=".GetVisualSelection()<cr><cr>
elseif has("unix")
vnoremap <silent> ?/ <Esc>:exec "/".GetVisualSelection()<cr>
vnoremap <silent> ?! <Esc>:exec "!firefox ".GetVisualSelection()<cr>
vnoremap <silent> ?? <Esc>:exec "!firefox https://www.sogou.com/web?query=".GetVisualSelection()<cr><cr>
endif

" for Pmenu Maps
inoremap <expr> <C-h> pumvisible() ? "<BS>" : "<C-h>"

" autocmd
au InsertEnter * set nu nornu
au InsertLeave * set nu rnu
au BufReadPost * normal! g`"
au CmdlineEnter * set cursorline cursorcolumn
au CmdlineLeave * set nocursorline nocursorcolumn
" autocmd! BufWritePost * :redraw! <bar> %s/\s\+$//e

" hide statusline on startify
au User StartifyReady set laststatus=0
au User StartifyBufferOpened set laststatus=2

" MiscellanousMenu
nnoremap <C-k> :set cursorline cursorcolumn<cr>
              \:call MiscellanousMenu()<cr>

" pairs
inoremap {<cr> {}<left><cr><Esc>O

" command, read stdout to new buffer
command -nargs=+ -complete=shellcmd Rsh new | setlocal nonu nornu | r! <args>
command -nargs=+ -complete=shellcmd TRsh tabe | setlocal nonu nornu | r! <args>


autocmd BufNewFile *.py,*.sh exec ":call ZeroLine()"
