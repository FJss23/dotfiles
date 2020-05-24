call plug#begin('~/.local/share/nvim/plugged')

" SYNTAX HIGHLIGHT AND THEME 
Plug 'posva/vim-vue'
" Plug 'kaicataldo/material.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/seoul256.vim'

" USABILITY
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mhinz/vim-startify'

" SEARCH
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" INTELLISENSE AND ANALYSIS
Plug 'neoclide/coc.nvim',{'branch' : 'release'}

" HELP WITH KEYBINDINGS
Plug 'liuchengxu/vim-which-key'

call plug#end()


" Remap
:imap jj <Esc>
map <Space> <Leader>
" Save files
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi
" Exit
nnoremap qq :q<cr>
" Move between splited viewports
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Exit terminal mode
:tnoremap jj <C-\><C-n>
" Move between tabs
nnoremap <A-h> gT
nnoremap <A-l> gt
tnoremap <A-h> gT
tnoremap <A-l> gt
" Move between buffers
nnoremap <S-TAB> :bprev<CR>
nnoremap <TAB> :bnext<CR>
" Move to the end of the line
nnoremap f $
vnoremap f $
" Move to the beginning of the line
nnoremap 0 _
vnoremap 0 _
" Move to the beginning of the line and inser mode
nnoremap <Leader>0 _i
vnoremap < <gv
vnoremap > >gv

" Show the name of the current file in the top of the window
set title
" Mouse integration
set mouse=a
" True color on terminal
set termguicolors
" Line number in file
set number
" Eliminate the visualization of the active mode
set noshowmode		 				
" Activate the syntaxis color
syntax on
let g:seoul256_background = 233
colo seoul256
" Activate the color scheme
" colorscheme material					
" Degine the theme for the airline
let g:lightline = { 'colorscheme': 'seoul256' }
" Deactivate option when save
let g:prettier#autoformat = 0				
" Deactivate option when save
let g:prettier#autoformat_require_pragma = 0
" Extensions files that will format
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" Hide line numbers on terminal mode
au TermOpen * setlocal nonumber norelativenumber
" Hide buffer unless explicity delete them
set hidden
nnoremap <Leader>h <C-W>s
nnoremap <Leader>v <C-W>v

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Search a file 
nnoremap <Leader>sf :Files<CR>
" Search word in current file
nnoremap <Leader>w :Rg<CR>
" Ag
noremap <Leader>sa :Ag<CR>
" Ag with the word under the cursor
noremap <Leader>se :exe ':Ag ' . expand('<cword>')<CR>
" List buffers
nnoremap <Leader>b :Buffers<CR>
" List of history search
nnoremap <Leader>sh :History<CR>
" Files under a git project
nnoremap <Leader>f :GFiles<CR>
" Files under a git project unstaged 
nnoremap <Leader>u :GFiles?<CR>
" Lines in loaded buffers
nnoremap <Leader>sl :Lines<CR>
" Lines under the current buffer
nnoremap <Leader>sL :BLines<CR>
" Tags in the project
nnoremap <Leader>st :Tags<CR>
" Tags in the current buffer
nnoremap <Leader>sT :BTags<CR>
" Marks
nnoremap <Leader>sm :Marks<CR>
" Commands
nnoremap <Leader>s; :Commands<CR>
" Commits
nnoremap <Leader>sc :Commits<CR>
" Buffers commits
nnoremap <Leader>sC :BCommits<CR>
" Maps
nnoremap <Leader>sM :Maps<CR>
" Open a zsh terminal
nnoremap <Leader>nt :tabnew term://zsh<CR>i
" Edit a new file
nnoremap <Leader>nf :e<Space>
" Close the current buffer 
nnoremap <Leader>c :bd!<CR>
" Deletes all buffers stop at first error
nnoremap <Leader>d :bufdo bd<CR>
" Open a zsh terminal
nnoremap <Leader>t :sp term://zsh<CR>i


call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'
let g:which_key_use_floating_win = 0

highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['/'] = ['gcc', 'comment']
let g:which_key_map['w'] = [':Rg', 'search text']
let g:which_key_map['b'] = [':Buffers', 'buffers']
let g:which_key_map['f'] = [':GFiles', 'files']
let g:which_key_map['u'] = [':GFiles?', 'unstaged files']
let g:which_key_map.n = {
	\ 'name' : '+new',
	\ 't' : [':tabnew term://zsh<CR>i', 'terminal in tab'],
	\ 'f' : [':e<Space>', 'new file']
	\}
let g:which_key_map['l'] = [':bd!<CR>', 'close buffer']
let g:which_key_map['d'] = [':bufdo bd<CR>', 'close buffers']
let g:which_key_map['t'] = [':sp term://zsh<CR>i', 'split terminal']
let g:which_key_map['h'] = ['<C-W>s', 'split below']
let g:which_key_map['S'] = [':Startify', 'start']
let g:which_key_map['v'] = ['<C-W>v', 'split right']
let g:which_key_map['n'] = [':NERDTreeToggle', 'nerdtree']
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ 'h' : [':History'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'all files'],
      \ 'l' : [':Lines'        , 'lines'],
      \ 'L' : [':Blines'	, 'lines in buffers'],
      \ 'm' : [':Marks'        , 'marks'],
      \ 'M' : [':Maps'         , 'keybindings'] ,
      \ 't' : [':Tags'         , 'project tags'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ 'e' : [':exe :Ag . expand(<cword>)<CR>', 'selected word']
      \ }
let g:which_key_map.r = {
      \ 'name' : '+rename-coc' ,
      \ 'n' : ['n'     , 'symbol renaming'],
      \ }
let g:which_key_map.c = {
      \ 'name' : '+formating-coc' ,
      \ 'f' : ['f'     , 'formating selected'],
	\ 'a' : ['f'     , 'diagnostics'],
	\ 'e' : ['f'     , 'extensions'],
	\ 'c' : ['f'     , 'commands'],
	\ 'o' : ['f'     , 'outline'],
	\ 's' : ['f'     , 'symbols'],
	\ 'j' : ['f'     , 'do default action next item'],
	\ 'k' : ['f'     , 'do default action previous item'],
      \ }
let g:which_key_map['a'] = ['a', 'codeAction-coc region']
let g:which_key_map.q = {
      \ 'name' : '+codeAction-coc' ,
      \ 'a' : ['a'     , 'apply to the current line'],
	\ 'f' : ['f'     , 'autofix line'],
      \ }

let s:header = [
			\'.######..######...####....####....####...######.',
			\'.##..........##..##......##..........##.....##..',
			\'.####........##...####....####....####.....###..',
			\'.##......##..##......##......##..##..........##.',
			\'.##.......####....####....####...######..#####..']

let g:startify_padding_left=60

function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)


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

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> ñg <Plug>(coc-diagnostic-prev)
nmap <silent> ñg <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>qa <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>

