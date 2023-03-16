let mapleader=' '
let maplocalleader=' '

inoremap qw {
inoremap wq }
inoremap qq [
inoremap ww ]
inoremap jk <Esc>
nnoremap <leader>j <cmd>w<cr>
nnoremap <leader>q <cmd>q<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <Up> <cmd>resize +2<CR>
nnoremap <Down> <cmd>resize -2<CR>
nnoremap <Left> <cmd>vertical resize +2<CR>
nnoremap <Right> <cmd>vertical resize -2<CR>

nnoremap <leader><leader> <c-^>
nnoremap <leader>, :ls<CR>:b<space>
nnoremap <leader>bk <cmd>bp\|bd! #<CR>

nnoremap <leader>co <cmd>copen<CR>
nnoremap <leader>ck <cmd>cclose<CR>
nnoremap <leader>cn <cmd>cnext<CR>
nnoremap <leader>cp <cmd>cprevious<CR>

nnoremap <leader>lo <cmd>lopen<CR>
nnoremap <leader>lk <cmd>lclose<CR>
nnoremap <leader>ln <cmd>lnext<CR>
nnoremap <leader>lp <cmd>lprevious<CR>

nnoremap <leader>tk <cmd>tabclose<CR>
nnoremap <leader>tn <cmd>tabnew<CR>

nnoremap <leader>sc <cmd>e $MYVIMRC<CR>

nnoremap <silent> <F2> <cmd>set spell!<CR>
inoremap <silent> <F2> <C-O><cmd>set spell!<CR>

set path+=**
set splitright 
set splitbelow 
set cursorline 
set hlsearch 
set mouse=a
set number 
set relativenumber 
set numberwidth
set breakindent 
set undofile 
set ignorecase 
set smartcase 
set noswapfile 
set scrolloff=7
set spellsuggest=best,9
set spelllang=en_us
set nospell
set updatetime=250
set signcolumn=no
set wildignore+=*.png,*.jpg,*/.git/*,*/node_modules/*,*/tmp/*,*.so,*.zip
set completeopt=menuone,noinsert,noselect
set nofoldenable 
set colorcolumn=90
set shiftwidth=4
set tabstop=4
set expandtab 
set termguicolors 

call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/prabirshrestha/vim-lsp'
Plug 'https://github.com/prabirshrestha/asyncomplete.vim'
Plug 'https://github.com/prabirshrestha/asyncomplete-lsp.vim'
Plug 'https://github.com/mattn/vim-lsp-settings'
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/junegunn/fzf.vim' | Plug '~/.fzf'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/lambdalisue/fern.vim'

" todo: move these colorscheme into /colors
Plug 'https://github.com/dracula/vim'
Plug 'https://github.com/gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox

" https://github.com/nickjj/dotfiles/blob/0c8abec8c433f7e7394cc2de4a060f3e8e00beb9/.vimrc#L444-L499
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

let g:user_emmet_install_global = 0

autocmd FileType html,css,javascript,javascriptreact,typescript,typescriptreact EmmetInstall

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'jsx',
\  },
\  'javascript.jsx' : {
\    'extends' : 'jsx',
\    'default_attributes': {
\      'label': [{'htmlFor': ''}],
\    }
\  },
\}

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

let g:lsp_settings = {
  \  'efm-langserver': {
  \    'disabled': 0,
  \    'args': ['-c='.expand('~/.config/efm-langserver/config.yaml')],
  \  },
\}

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <buffer> <expr><c-u> lsp#scroll(+4)
    " nnoremap <buffer> <expr><c-i> lsp#scroll(-4)

    if has('nvim')
        nnoremap <buffer> <leader>ca :LspCodeAction<CR>
        xnoremap <buffer> <leader>ca :LspCodeAction<CR>
    else
        nmap <buffer> ca <Plug>(lsp-code-action-float)
    endif

    nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
    vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
    nnoremap <buffer> <leader>cl :LspCodeLens<CR>

    let g:lsp_format_sync_timeout = 1000

    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    autocmd! BufWritePre *.js,*.jsx,*.ts,*.tsx,*.go call execute('LspCodeActionSync source.organizeImports')
    autocmd! BufWritePre *.js,*.jsx,*.ts,*.tsx call execute('LspDocumentFormatSync --server=efm-langserver')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

autocmd User lsp_float_opened nmap <buffer> <silent> <leader>e
          \ <Plug>(lsp-preview-close)
autocmd User lsp_float_closed nunmap <buffer> <leader>e

let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_documentation_float_docked = 1
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_semantic_enabled = 1
let g:lsp_code_actions_use_popup_menu = 1
let g:lsp_use_native_client = 1
let g:lsp_preview_float = 1
let g:lsp_document_highlight_enabled = 0

hi! LspErrorHighlight guifg=#dc322f guibg=NONE guisp=#dc322f gui=undercurl cterm=undercurl
hi! LspInfoHighlight guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl
hi! LspWarningHighlight guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl
hi! LspHintHighlight guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }

nnoremap <leader>sf :Files<CR>
nnoremap <leader>? :History<CR>
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sg :Rg<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)

" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

nnoremap rw :Grep<space><c-r><c-w><CR>
