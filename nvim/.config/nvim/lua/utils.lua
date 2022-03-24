-- Config for various plugins
require'colorizer'.setup()
require('nvim-ts-autotag').setup()

-- require'nvim-tree'.setup{
--   disable_netrw = true,
--   git = {
--     enable = false,
--   },
--   view = {
--     hide_root_folder = true,
--     side = 'right'
--   },
-- }

-- vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle <CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>fr', ':NvimTreeRefresh <CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>fn', ':NvimTreeFindFile <CR>', { noremap = true })

require'gitsigns'.setup({
    signcolumn = true
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

-- require'diffview'.setup()
