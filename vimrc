" -------------------------------------------------------------
" .vimrc OSX
" -------------------------------------------------------------

set nocompatible "Use vim (as opposed to vi) settings

set nu ruler "Show line numbers and cursor position

set softtabstop=4 shiftwidth=4 expandtab "Use four spaces for a tab 

set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set laststatus=2

syntax on

set selectmode=mouse
set backupdir=/tmp
set directory=/tmp

set modelines=0         " CVE-2007-2438
set backspace=2         " more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

