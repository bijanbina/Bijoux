if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
set nu
set autoindent
set cindent
colorscheme Tomorrow-Night-Eighties
if has('gui_running')
  set guifont=Source\ Code\ Pro\ Medium\ 10
endif
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
hi link cIncluded PreProc
set tabstop=4
