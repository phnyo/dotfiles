set fileencodings=utf-8

set tabstop=2
set shiftwidth=2
set expandtab

set laststatus=2
set number
set cursorline
set autoindent
set smartindent

set backupdir=~/.cache/vim/backup/
set dir=~/.cache/vim/swp/

set noerrorbells
set foldmethod=manual

set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
set incsearch

syntax on

nnoremap <C-j> }
nnoremap <C-k> {

" nerdtree settings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" vim-plug plugins
call plug#begin('~/.vim/plugged')
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'preservim/nerdtree'
call plug#end()

" statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  "'.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ set statusline+=%{StatuslineGit()}
