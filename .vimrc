set fileencodings=utf-8
set encoding=utf-8
"packadd! dracula
"colorscheme dracula 
colorscheme molokai
"colorscheme srcery
"colorscheme tender
"
augroup TransparentBG
  	autocmd!
	autocmd Colorscheme * highlight Normal ctermbg=none
	autocmd Colorscheme * highlight NonText ctermbg=none
	autocmd Colorscheme * highlight LineNr ctermbg=none
	autocmd Colorscheme * highlight Folded ctermbg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
	autocmd Colorscheme * highlight CursorLine ctermfg=LightBlue ctermbg=none
augroup END

set tabstop=2
set shiftwidth=2
set expandtab

set laststatus=2
set number
set cursorline
set autoindent
set smartindent

set showmode

"set backupdir=~/.cache/vim/backup/
"set dir=~/.cache/vim/swp/

set noerrorbells
set foldmethod=manual
set foldlevel=0
set foldcolumn=5

set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
set incsearch
set wildmenu

set splitright

syntax on

nnoremap <C-j> }
nnoremap <C-k> {
nnoremap <C-s> :w<CR>
nnoremap <C-d> :term ++rows=10 <CR><C-W><C-R>
nnoremap <C-d>v :vert term ++cols=40<CR><C-W>R
nnoremap <silent> <Space><Space> :let @/ = '\<' . expand('<cword>') . '\>'<CR>:set hlsearch<CR>

" nerdtree settings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" lsp-vim settings
nnoremap <C-f> :LspDocumentFormatSync<CR>

" vim-plug plugins
call plug#begin('~/.vim/plugged')
""    Plug 'itchyny/lightline.vim'
  Plug 'lervag/vimtex'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'preservim/nerdtree'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'skanehira/preview-markdown.vim'
call plug#end()

let g:lsp_diagnostics_enabled = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if (executable('haskell-language-server-wrapper'))
  au User lsp_setup call lsp#register_server({
      \ 'name': 'haskell-language-server-wrapper',
      \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
      \ 'whitelist': ['haskell'],
      \ })
endif

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" statusline

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  let l:branchlen = strlen(l:branchname)
  if l:branchname == "main" || l:branchname == "master"
    hi PmenuSel ctermfg=White ctermbg=Red
    return '  CUR_BR: '.l:branchname.' '
  elseif l:branchname != "HEAD"
    hi PmenuSel ctermfg=White ctermbg=Blue
    return '  CUR_BR: '.l:branchname.' '
  else
    hi PmenuSel ctermfg=White ctermbg=Black
    return '  Git Uninitialized '
  endif
endfunction

function! SetModeColors(mode)
  if a:mode == 'i'
    hi CursorColumn ctermfg=White ctermbg=DarkMagenta
    return '[INSERT]'
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == 'CTRL-V'
    hi CursorColumn ctermfg=White ctermbg=DarkGreen
    return '[VISUAL]'
  elseif a:mode == 'n'
    hi CursorColumn ctermfg=White ctermbg=DarkCyan
    return '[NORMAL]'
  elseif a:mode == 'R'
    hi CursorColumn ctermfg=White ctermbg=Brown
    return '[REPLACE]'
  else
    hi CursorColumn ctermfg=White ctermbg=Black
    return '[UNDEF]'
  endif
endfunction

hi PmenuSel ctermfg=White ctermbg=NONE
hi CursorColumn ctermfg=White ctermbg=DarkBlue
hi LineNr ctermfg=White ctermbg=NONE

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{SetModeColors(mode())}
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

