-- ................................................................................
-- Configuration for treesitter (better syntax highlight)

require'nvim-treesitter.configs'.setup {
    autotag = {enable = true},
    highlight = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {enable = true},
    rainbow = {enable = true, disable = {'html'}}
}

-- ................................................................................
-- configuration for neogen (generate documentation for functions)
require("bufferline").setup{}

-- ................................................................................
-- configuration for neogen (generate documentation for functions)

require('neogen').setup()

-- ................................................................................
-- Configuration for colorized (shows the color of the hex color)

require'colorizer'.setup()

-- ................................................................................
-- Configuration for fzf-lua (Use fzf inside neovim with some additional functionality)

require'fzf-lua'.setup({
    winopts = {width = 0.6, height = 0.6, --[[split = "belowright new",--]] preview = {hidden = "hidden"}},
    files = {git_icons = false}
})

vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua files <CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fo', ':FzfLua oldfiles <CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':FzfLua buffers <CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>fw', ':FzfLua grep_cword <CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fk', ':FzfLua live_grep_native <CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', ':FzfLua grep <CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>fs', ':FzfLua lsp_document_symbols <CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>fi', ':FzfLua git_files <CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fgc', ':FzfLua git_commits <CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fgb', ':FzfLua git_branches <CR>', {noremap = true})

vim.cmd("FzfLua register_ui_select")

-- ................................................................................
-- Configuration for Comment (Comment a line of almost every language, also comment multiple
-- lines, all at once, it can support jsx)

require('Comment').setup()
