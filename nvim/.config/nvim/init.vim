syntax on
filetype plugin indent on

set path+=**
set signcolumn=yes
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nobackup
set noswapfile
set scrolloff=7
set completeopt=menu,menuone,noinsert,noselect
set mouse=a
set spellsuggest=best,9
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
set nowrap
set termguicolors
set number
set guicursor=

" ................................................................................
" Plugins

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp' | Plug 'hrsh7th/nvim-cmp' | Plug 'hrsh7th/cmp-buffer' | Plug 'ray-x/lsp_signature.nvim'
Plug 'danymat/neogen'
Plug 'L3MON4D3/LuaSnip'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
Plug 'rvighne/vim-one'

Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-test/vim-test'
Plug 'chrisbra/Colorizer'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'mbbill/undotree'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf.vim'
call plug#end()

" ................................................................................
" Mappings (check config.lua for lsp mappings)

let mapleader=" "
:imap jk <Esc>
nnoremap <leader>s :w<cr>
nnoremap <leader>qq :q<cr>
nnoremap <leader>fd :find 
nnoremap <leader>rg :Rgrep 

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

noremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

command! BufOnly execute '%bdelete|edit #|normal `"'
nnoremap <leader>bq :BufOnly <CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>, :ls<cr>:b<space>
nnoremap <leader>bk :bp\|bd! #<CR>

nnoremap <leader>bf gggqG
nnoremap <leader>bc :make % \| cwindow<CR>

nnoremap <leader>co :copen<CR>
nnoremap <leader>ck :cclose<CR>
nnoremap <leader>cf :cfirst<CR>
nnoremap <leader>cl :cclast<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>

nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lk :lclose<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>

nnoremap <leader>tk :tabclose<cr>
nnoremap <leader>tn :tabnew<cr>

nnoremap <leader>md :delm!<CR> :delm A-Z0-9<CR>

nnoremap <space>O :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <space>o :<c-u>put =repeat(nr2char(10), v:count1)<cr>

nnoremap n nzz
nnoremap N Nzz
nnoremap / ms/
nnoremap ? ms?

nnoremap <Leader>da :Sexplore<CR>
nnoremap <leader>dd :Sexplore %:p:h<CR>
nnoremap <Leader>df :let @/=expand("%:t") <Bar> execute 'Sexplore' expand("%:h") <Bar> normal n<CR>

nnoremap <silent> <F2> :set spell!<cr>
inoremap <silent> <F2> <C-O>:set spell!<cr>

nnoremap <F3> :TSContextToggle<cr>

nnoremap <F4> :UndotreeToggle<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fh :FZF ~<CR>

nnoremap ñ :Rgrep <cword>*<CR>
nnoremap <leader>ñ :Rgrep <cword>%:p:h/*<CR>
nnoremap ç :Rgrep '\b<cword>\b'*<CR>
nnoremap <leader>ç :Rgrep '\b<cword>\b'%:p:h/*<CR>

tnoremap fd <C-\><C-n>
tnoremap <esc> <C-\><C-n>
tnoremap <C-v><esc> <esc>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

nnoremap <leader>p "0p
nnoremap <leader>P "0P

" ................................................................................
" Other global stuff

if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
endif

autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

autocmd FileType lua,c,go setlocal shiftwidth=4 tabstop=4

autocmd BufWritePre *.go lua OrgImports(1000)

autocmd BufWinEnter,WinEnter *.svelte set syntax=html

autocmd FileType html,pug setlocal shiftwidth=2 tabstop=2

" hi DiagnosticUnderlineWarn gui=underline
" hi DiagnosticUnderlineError gui=underline
" hi DiagnosticUnderlineHint gui=underline
" hi DiagnosticUnderlineInfo gui=underline

" hi DiagnosticSignWarn guibg=yellow guifg=black
" hi DiagnosticSignError guibg=red guifg=black
" hi DiagnosticSignHint guibg=green guifg=black
" hi DiagnosticSignInfo guibg=blue guifg=black

" ................................................................................
" Colorized configuration

let g:colorizer_auto_filetype = 'css,html,javacript,typescript,javascriptreact,typescriptreact'
let g:colorizer_colornames = 0
let g:colorizer_skip_comments = 1
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ................................................................................
" FZF configuration

set runtimepath^=~/.fzf
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ................................................................................
" Function to identify highlight groups
" https://stackoverflow.com/questions/10692289/proper-html-attribute-highlighting-in-vim thanks!

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" ................................................................................
" QuickFix specific stuff
" Rgrep: grep + quickfix list. Source: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
" quickfix: Don't show the preview after grep
" https://vim.fandom.com/wiki/Search_for_current_word_in_multiple_files

function! Rgrep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Rgrep  cgetexpr Rgrep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LRgrep lgetexpr Rgrep(<f-args>)

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END


" ................................................................................
" Netrw basic configuration

let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_localrmdir='rm -r'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_banner = 0

hi! link netrwMarkFile Search

function! NetrwMapping()
  nmap <buffer> <leader>da :Sexplore<CR>
  nmap <buffer> <leader>dd :Sexplore %:p:h<CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" ................................................................................
" Terminal usage

let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

autocmd BufWinEnter,WinEnter term://* startinsert

" ................................................................................
" Disabling some built in plugins

let g:loaded_matchparen = 1
let g:loaded_matchit = 1
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

" ................................................................................
" Lua files

lua <<EOF
require('config')
EOF

