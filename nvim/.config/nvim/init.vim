" fjss23 <fjriedemann@gmail.com>
" Search pattern in this file (don't judge, I like having all of this in one file): 
"      plug:<plugin_name>
"      lsp:<language_name>

" todo: put all the specific configuration for vim plugins into
" plugin_options.
"
" todo: create folders for specific filetypes

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
set colorcolumn=90
set shiftwidth=4
set tabstop=4
set expandtab 
set termguicolors 

call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/nvim-cmp' | Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/junegunn/fzf.vim' | Plug '~/.fzf'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/obaland/vfiler.vim'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/dracula/vim'
call plug#end()

colorscheme dracula

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

nnoremap <leader>da :VFiler -auto-resize -keep -layout=left -name=explorer -width=30 -columns=indent,name<CR>

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

hi DiagnosticUnderlineError cterm=undercurl gui=undercurl
hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl
hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl

hi! link Todo diffFileId

hi! link DiagnosticLineNrError DiagnosticError
hi! link DiagnosticLineNrWarn DiagnosticWarn
hi! link DiagnosticLineNrInfo DiagnosticInfo
hi! link DiagnosticLineNrHint DiagnosticHint

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

lua <<EOF
-- Treesitter {{{
require('nvim-treesitter.configs').setup {
    ensure_installed = { 
        'javascript', 
        'jsdoc', 
        'typescript', 
        'tsx', 
        'help', 
        'css', 
        'scss'
    },
    highlight = { enable = true },
    indent = { enable = true },
}
--}}}

local cmp = require 'cmp'
local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- Cmp {{{
cmp.setup {
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    formatting = {
        format = function (entry, vim_item)
            vim_item.menu = ({ nvim_lsp = '[LSP]' })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    },
}
--}}}

-- Lsp Config {{{
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        severity_sort = true,
        source = 'always',
        show_header = true,
        focusable = false,
    }
})

keymap.set('n', 'dp', vim.diagnostic.goto_prev)
keymap.set('n', 'dn', vim.diagnostic.goto_next)
keymap.set('n', '<leader>e', vim.diagnostic.open_float)
keymap.set('n', '<leader>le', vim.diagnostic.setloclist)

local on_attach = function(client, bufnr)
    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
    keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr })
    keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr })
    keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { buffer = bufnr })
    keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { buffer = bufnr })
    keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    keymap.set('i', '<c-k>', vim.lsp.buf.hover, { buffer = bufnr })
    keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
    keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
    keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
    keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = bufnr })

    if client.name ~= "tsserver" then
        keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end
end

local servers = { 
    'tsserver', 
    'cssls', 
    'cssmodules_ls', 
    'astro',
    'bashls',
    'pylsp',
    'cmake',
    'clangd',
    'dockerls',
    'prismals'
}

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
--}}}

-- Yaml {{{
lspconfig.yamlls.setup {
    settings = {
    yaml = {
        schemaStore = {
            url = "https://www.schemastore.org/api/json/catalog.json",
            enable = true,
        }
      }
    },
    on_attach = on_attach,
    capabilities = capabilities
}
--}}}

-- Javascript / Typescript {{{
local function js_org_imports()
    local params = {
        command = '_typescript.organizeImports',
        arguments = { api.nvim_buf_get_name(0) },
        title = ''
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            js_org_imports,
            description = 'Orginze js and ts imports'
        }
    }
})

lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = "all"
        },
    }
})
--}}}

-- Go {{{
local go_path_bin = home .. '/.asdf/installs/golang/1.19.5/packages/bin/'

local function go_org_imports()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' }}
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { go_path_bin .. 'gopls', 'serve' },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    },
    commands = {
        OrganizeImports = {
            go_org_imports,
            description = 'Orginze go imports'
        }
    }
})

lspconfig.golangci_lint_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { go_path_bin .. 'golangci-lint-langserver' },
    init_options = {
        command = { go_path_bin .. 'golangci-lint', 'run', '--out-format', 'json' }
    }
    
})
--}}}

keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', {silent = true})

-- LaTeX {{{
local texlab_path_bin = home .. '/.config/nvim/lsp-langs/texlab'

lspconfig.texlab.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { texlab_path_bin },
})
--}}}

-- Rust {{{
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = 'clippy'
            }
        }
    }
})
--}}}

-- Efm {{{
lspconfig.efm.setup({
    init_options = {
        documentFormatting = true,
        codeActions = false,
    },
    cmd = { 'efm-langserver', '-c', home .. '/.config/efm-langserver/config.yaml' },
    filetypes = { 
        'javascript', 
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'yaml'
    },
    on_attach = on_attach,
})
--}}}

-- Status Line {{{
local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return ' ' .. branch .. " |"
	else
		return ""
	end
end

function status_line() 
    local file = '%f'
    local modifiers = '%m%r%h%w%q'
    local lsp_info = [[%{luaeval("diagnostic_status()")}]]
    local file_type = '%y'
    local line_info = '%l/%L:%c'
    local encoding = '%{&fenc}'
    local file_format = '%{&ff}'

    return table.concat({
        ' %{mode()}', ' | ' ,vim.b.branch_name, ' ', file,' ', modifiers,' ', lsp_info, '%=', encoding, ' ', file_type, ' ', file_format, ' | ', line_info, ' '
    })
end

-- Thanks! https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
function diagnostic_status()
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if num_errors > 0 then
    return ' 💀 ' .. num_errors .. ' '
  end

  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if num_warnings > 0 then
    return ' 💩' .. num_warnings .. ' '
  end
  return ''
end

api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.branch_name = branch_name()
	end
})
--}}}

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})
EOF

set statusline=%!v:lua.status_line()

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
