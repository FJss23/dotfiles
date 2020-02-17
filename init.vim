call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'	
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'  
Plug '~/.fzf'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'sheerun/vim-polyglot'
call plug#end()

set title                 " Muestra el nombre del archivo en la ventana de la terminal
set cursorline            " Resalta la linea actual
set mouse=a               " Permite la integracion del mouse
set termguicolors         " Activa true colors en la terminal
set number		  " Activa el numero de linea

color onedark

:imap jj <Esc>

let g:airline#extensions#tabline#enabled = 1          " Mostrar los buffers abiertos como pestañas
let g:airline#extensions#tabline#fnamemod = ':t'      " Muestra solo el nombre del archibo

map <F2> :NERDTreeToggle<CR>
map <Space> <Leader>

nnoremap <C-p> :FZF<CR>

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
