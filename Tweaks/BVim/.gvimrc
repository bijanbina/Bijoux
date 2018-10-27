set go=aci
call system("wmctrl -i -r ".v:windowid." -b toggle,fullscreen")
redraw
function! ToggleFullScreen()
   call system("wmctrl -i -r ".v:windowid." -b toggle,fullscreen")
   redraw
endfunction
colorscheme bijan
nnoremap <M-f> :call ToggleFullScreen()<CR>
inoremap <M-f> <C-\><C-O>:call ToggleFullScreen()<CR>
nnoremap <F5> :wa<CR>:!./build.sh<CR>
inoremap <F5> <C-\><C-O>:wa<CR><C-\><C-O>:!./build.sh<CR>
set guicursor=n-v-c:hor1-Cursor/lCursor,ve:hor1-Cursor,o:hor50-Cursor,i-ci:hor1-Cursor/lCursor,r-cr:hor1-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
nmap <S-Enter> o<Esc>
:set nowrap textwidth=0 wrapmargin=0
