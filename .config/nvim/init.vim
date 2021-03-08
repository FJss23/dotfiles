" Plugins

call plug#begin('~/.local/share/nvim/plugged')

Plug 'norcalli/nvim-colorizer.lua'
Plug 'gruvbox-community/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim',{'branch' : 'release'}
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'

call plug#end()


" Remap defaults

:imap jk <Esc>
let mapleader=" "
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>i
nnoremap qq :q<cr>
:tnoremap jk <C-\><C-n>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <A-h> gT
nnoremap <A-l> gt
tnoremap <A-h> gT
tnoremap <A-l> gt
nnoremap <S-TAB> :bprev<CR>
nnoremap <TAB> :bnext<CR>
nnoremap <Leader>x <C-W>s
nnoremap <Leader>v <C-W>v
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>z :tabnew term://zsh<CR>i
nnoremap <Leader>k :bp\|bd! #<CR>
nnoremap <Leader>v :bufdo bd<CR>
nnoremap <Leader>b :belowright split term://zsh<CR>i
nnoremap <Leader>ñ :te zsh<CR>i


" General options

set title
set mouse=a
set termguicolors
set relativenumber
set noshowmode
syntax on
au TermOpen * setlocal nonumber norelativenumber
set hidden
set smartindent
set wrap
set incsearch
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set number
autocmd Filetype java setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd Filetype c setlocal shiftwidth=4 softtabstop=4 expandtab
set nohlsearch
set nowritebackup
set nobackup
set shortmess+=c
set updatetime=300
set background=dark

if executable('rg')
  let g:rg_derive_root='true'
endif

                                  
" Plugin: Gruvbox

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox


" Plugin: Prettier
                                 
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#exec_cmd_async=1
let g:prettier#config#parser=''
let g:prettier#config#use_tabs='false'
let g:prettier#config#tab_width='2'


" Plugin: FZF

nnoremap <Leader>1 :History<CR>
nnoremap <Leader>2 :History:<CR>
nnoremap <Leader>3 :History/<CR>
nnoremap <Leader>4 :Commands<CR>
nnoremap <Leader>f :Files<CR>
noremap <Leader>s :Rg<CR>
noremap <Leader>e :exe ':Rg ' . expand('<cword>')<CR>
nnoremap ç :Buffers<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>u :GFiles?<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>i :BLines<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>c :Commits<CR>
nnoremap <Leader>w :BCommits<CR>


" Plugin: Colorizer

lua require'colorizer'.setup()


" Plugin: Emmet
                                    
autocmd FileType html EmmetInstall


" Plugin: COC

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <C-n> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-m> <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <leader>r <Plug>(coc-rename)

xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>av  <Plug>(coc-fix-current)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif(coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Plugin: Lightline

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


" Plugin: Nerdtree
 
map <F2> :NERDTreeToggle<CR>

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
