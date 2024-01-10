set runtimepath^=~/.vim runtimepath+=~/.vim/after
set runtimepath+=~/.config/nvim
set runtimepath+=~/.local/share/nvim/site
let &packpath = &runtimepath

set fileencodings=utf-8
set encoding=utf-8

augroup TransparentBG
  	autocmd!
	autocmd Colorscheme * highlight Normal ctermbg=none 
  autocmd Colorscheme * highlight NonText ctermbg=none 
  autocmd Colorscheme * highlight LineNr ctermbg=none 
  autocmd Colorscheme * highlight Folded ctermbg=none autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
	autocmd Colorscheme * highlight CursorLine cterm=underline ctermfg=yellow ctermbg=none
augroup END

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END


set tabstop=2
set shiftwidth=2
set expandtab

set nobackup
set noswapfile

set laststatus=2
set number
set cursorline
set autoindent
set smartindent

set showmode
set display=uhex
set wrap
set splitright
set splitbelow

set backupdir=~/.cache/vim/backup/
set dir=~/.cache/vim/swp/

set noerrorbells
set foldmethod=manual
set foldlevel=0
set foldcolumn=5

set hlsearch
set incsearch
set wildmenu

syntax on

let g:indentLine_char = '|'

nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
nnoremap <C-j> }
nnoremap <C-k> {
nnoremap <C-s> :w<CR>
nnoremap <silent> <Space><Space> :let @/ = '\<' . expand('<cword>') . '\>'<CR>:set hlsearch<CR>

" nerdtree settings
" nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" vim-plug plugins
call plug#begin('~/.vim/plugged')
  Plug 'lervag/vimtex'
  Plug 'nvim-lualine/lualine.nvim'
	Plug 'preservim/nerdtree'
  Plug 'honza/vim-snippets'
  Plug 'machakann/vim-sandwich'
  Plug 'skanehira/preview-markdown.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'craigmac/vim-mermaid'
  Plug 'anuvyklack/pretty-fold.nvim'
  Plug 'phnyo/chatgpt-vi'
  Plug 'github/copilot.vim'
  Plug 'rhysd/vim-clang-format'
  Plug 'vim-scripts/DoxygenToolkit.vim'
  Plug 'sakhnik/nvim-gdb'
call plug#end()

let g:lsp_diagnostics_enabled = 1

let g:clang_format#style_options = {
  \ "BasedOnStyle" : "llvm",
  \ "AlignConsecutiveAssignments": "true",
  \ "BreakBeforeBraces" : "Linux",
  \ "Cpp11BracedListStyle" : "true",
  \ "IndentWidth" : 4,
  \ "Standard" : "C++11",
  \ "TabWidth" : 4}

autocmd FileType c,cpp,objc nnoremap <buffer><Leader><C-f> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader><C-f> :ClangFormat<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd BufWinEnter *.py nmap <silent> <C-d>:w<CR>:terminal python3 -m pdb '%:p'<CR> 
" statusline
"
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  let l:branchlen = strlen(l:branchname)
  if l:branchname == "main" || l:branchname == "master"
    hi PmenuSel ctermfg=White ctermbg=DarkMagenta
    return '  CUR_BR: '.l:branchname.' '
  elseif l:branchname != "HEAD"
    hi PmenuSel ctermfg=White ctermbg=DarkBlue
    return '  CUR_BR: '.l:branchname.' '
  else
    hi PmenuSel ctermfg=White ctermbg=Black
    return '  Git NOTINIT '
  endif
endfunction

function! SetModeColors(mode)
  if a:mode == 'i'
    hi CursorColumn ctermfg=White ctermbg=DarkBlue
    return '[INSERT]'
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == 'CTRL-V'
    hi CursorColumn ctermfg=White ctermbg=DarkMagenta
    return '[VISUAL]'
  elseif a:mode == 'n'
    hi CursorColumn ctermfg=White ctermbg=DarkYellow
    return '[NORMAL]'
  elseif a:mode == 'R'
    hi CursorColumn ctermfg=White ctermbg=DarkGray
    return '[REPLACE]'
  else
    hi CursorColumn ctermfg=White ctermbg=Black
    return '[UNDEF]'
  endif
endfunction


let g:mapleader=","
" au BufWritePost *.cpp LspDocumentFormat 
" au BufWritePost *.c LspDocumentFormat 
" au BufWritePost *.py LspDocumentFormat 

hi PmenuSel ctermfg=White ctermbg=NONE
hi CursorColumn ctermfg=White ctermbg=DarkBlue
hi LineNr ctermfg=White ctermbg=NONE

set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %{SetModeColors(mode())}
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
set statusline+=\ 

