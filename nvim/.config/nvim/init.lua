vim.opt.path:append {'**'}
vim.opt.writebackup = false
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.scrolloff = 7
vim.opt.completeopt:append {'menu','menuone','noinsert','noselect'}
vim.opt.spellsuggest = {'best', '9'}
vim.opt.wildignore:append {"*.png","*.jpeg","*jpg","*/.git/*","*/node_modules/*"}
vim.opt.wrap = false
vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.nuw = 2
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")

-- Plugins. https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom

local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.local/share/nvim/plugged")
Plug 'https://github.com/MaxMEllon/vim-jsx-pretty'
Plug 'https://github.com/NvChad/nvim-colorizer.lua'

Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/jremmen/vim-ripgrep'

Plug 'https://github.com/L3MON4D3/LuaSnip'
Plug 'https://github.com/itchyny/vim-gitbranch'

Plug 'https://github.com/junegunn/fzf.vim'

Plug('https://github.com/neoclide/coc.nvim', { branch = 'release'})
vim.call("plug#end")

-- Mapping

local kopts = {noremap = true, silent = true}

vim.g.mapleader=" "
vim.keymap.set('i', 'jk', '<Esc>', kopts)
vim.keymap.set('n', '<leader>s', ':w<cr>', kopts)
vim.keymap.set('n', '<leader>qq', ':q<cr>', kopts)
vim.keymap.set('n', '<leader>fd', ':find', kopts)
vim.keymap.set('n', '<leader>rg', ':Rg', kopts)

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", kopts)
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", kopts)

vim.keymap.set('n', '<Up>', ':resize +2<CR>', kopts)
vim.keymap.set('n', '<Down>', ':resize -2<CR>', kopts)
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', kopts)
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', kopts)

vim.keymap.set('n', '<leader><leader>', '<c-^>', kopts)
vim.keymap.set('n', '<leader>,', ':ls<cr>:b<space>', kopts)
vim.keymap.set('n', '<leader>bk', [[:bp\|bd! #<CR>]], kopts)

vim.keymap.set('n', '<leader>co', ':copen<CR>', kopts)
vim.keymap.set('n', '<leader>ck', ':cclose<CR>', kopts)
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', kopts)
vim.keymap.set('n', '<leader,>cp', ':cprevious<CR>', kopts)

vim.keymap.set('n', '<leader>lo', ':lopen<CR>', kopts)
vim.keymap.set('n', '<leader>lk', ':lclose<CR>', kopts)
vim.keymap.set('n', '<leader>ln', ':lnext<CR>', kopts)
vim.keymap.set('n', '<leader>lp', ':lprevious<CR>', kopts)

vim.keymap.set('n', '<leader>tk', ':tabclose<cr>', kopts)
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', kopts)

vim.keymap.set('n', '<silent> <F2>', ':set spell!<cr>', kopts)
vim.keymap.set('i', '<silent> <F2>', '<C-O>:set spell!<cr>', kopts)

vim.keymap.set('n', '<leader>ff', ':Files<CR>', kopts)
vim.keymap.set('n', '<leader>fr', ':History<CR>', kopts)
vim.keymap.set('n', '<leader>fg', ':Rg<CR>', kopts)
vim.keymap.set('n', '<leader>fh', ':FZF ~<CR>', kopts)

vim.keymap.set('n', 'ç', ':Rg<CR>', kopts)

vim.keymap.set('i', 'qw', '{', kopts)
vim.keymap.set('i', 'wq', '}', kopts)
vim.keymap.set('i', 'qq', '[', kopts)
vim.keymap.set('i', 'ww', ']', kopts)

-- Other global stuff

vim.cmd('colorscheme gruvbox')
vim.cmd('hi! link statusline cursorline')

local branch = vim.fn['gitbranch#name']()
local git = ""

if branch ~= "" then
  git = "git:" .. branch
end

vim.o.statusline = "[%n] ".. git .. " %l, %c (%L) %f%m%r%h%w %q "

-- Utility

require('colorizer').setup()

require('luasnip.loaders.from_snipmate').lazy_load()

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local cocTriggerOpts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', cocTriggerOpts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], cocTriggerOpts)
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], cocTriggerOpts)
vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
vim.keymap.set("n", "<leader>n", "<Plug>(coc-diagnostic-prev)", {silent = true})
vim.keymap.set("n", "<leader>N", "<Plug>(coc-diagnostic-next)", {silent = true})
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

local cocCaOpts = {silent = true, nowait = true}
vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", cocCaOpts)
vim.keymap.set("n", "<leader>as", "<Plug>(coc-codeaction-source)", cocCaOpts)
vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", cocCaOpts)
vim.keymap.set("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
vim.keymap.set("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
vim.keymap.set("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

local cocDocOpts = {silent = true, nowait = true, expr = true}
vim.keymap.set("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', cocDocOpts)
vim.keymap.set("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', cocDocOpts)
vim.keymap.set("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', cocDocOpts)
vim.keymap.set("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', cocDocOpts)
vim.keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', cocDocOpts)
vim.keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', cocDocOpts)

vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

vim.keymap.set("n", "<space>c", ":<C-u>CocList commands<cr>", opts)

-- Search

vim.opt.runtimepath:prepend {'~/.fzf'}
vim.g['fzf_layout'] = {down = '~30%'}
vim.g['fzf_preview_window'] = {'right:40%:hidden', 'ctrl-/'}
