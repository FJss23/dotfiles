require'colorizer'.setup()

require'indent_blankline'.setup {
    show_current_context = true,
    show_current_context_start = true,
}

vim.g['indent_blankline_enabled'] = false
vim.g['indent_blankline_use_treesitter'] = true

vim.api.nvim_set_keymap('n', '<F3>', ':IndentBlanklineToggle<CR>', { noremap = true })

require'Comment'.setup()

require'nvim-autopairs'.setup()

require'nvim-tree'.setup{
  disable_netrw = true,
  git = {
    enable = false,
  },
  view = {
    hide_root_folder = true,
  }
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fr', ':NvimTreeRefresh <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fn', ':NvimTreeFindFile <CR>', { noremap = true })

require'gitsigns'.setup({
    signcolumn = false
})

vim.api.nvim_set_keymap('n', '<F5>', ':Gitsigns toggle_signs <CR>', { noremap = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
