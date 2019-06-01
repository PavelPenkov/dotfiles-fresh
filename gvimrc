" No audible bell
set vb
set nocursorline

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Command-T
if has("gui_macvim")
   macmenu &File.New\ Tab key=<nop>
   macmenu &Tools.Make key=<nop>
endif

" Window size
set columns=207
set lines=63

" Local config
if filereadable($HOME . "/.gvimrc.local")
  source ~/.gvimrc.local
endif

" set guifont=DejaVu\ Sans\ Mono:h14
