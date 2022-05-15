vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1

-- @Fixme I couldn't change the color of comments
local palettes = {
  nightfox = {
    comments = "#fff"
  }
}

require'nightfox'.setup({
  palettes = palettes,
  options = {
    transparent = false,
    styles = {
      types = "bold",
      functions = "bold",
    }
  }
})

-- @Info First declare and define the colorscheme, then change the color of indentation lines
vim.cmd("colorscheme nightfox")

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.termguicolors = true

vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_enabled = true

vim.cmd [[highlight IndentBlanklineIndent1 guifg=gray29 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar  guifg=gray49 gui=nocombine]]
-- @Info Change the color of the underline when using show_current_context_start
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=gray49 gui=underline]]

require("indent_blankline").setup {
  show_end_of_line = true,
  buftype_exclude = {'terminal', 'nofile', 'NvimTree'},
  filetype_exclude = {'help', 'NvimTree'},
  show_current_context = true,
  char_highlight_list = {"IndentBlanklineIndent1"},
  -- show_current_context_start = true,
}

vim.api.nvim_set_keymap('n', '<F4>', ':IndentBlanklineToggle <CR>', { noremap = true })

require'gitsigns'.setup({
  signcolumn = true,
  -- signs = {
  --   add = { hl = 'GitSignsAdd', text = '▌ ' },
  --   change = { hl = 'GitSignsChange', text = '▌ ' },
  --   delete = { hl = 'GitSignsDelete', text = '▌ ' },
  --   topdelete = { hl = 'GitSignsDelete', text = '▌ ' },
  --   changedelete = { hl = 'GitSignsChange', text = '▌ ' },
  -- },
})

vim.api.nvim_set_keymap('n', '<F5>', ':Gitsigns toggle_signs <CR>', { noremap = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
require('nvim-autopairs').setup()

require('bqf').setup({
  preview = {
    border_chars = {'│', '│', '─', '─', '┌', '┐', '└', '┘', ''},
  }
})

require('nvim-tree').setup{
  git = {
    enable = false
  },
  view = {
    side = "right",
    width = '25%',
    hide_root_folder = true,
  }
}

vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile <CR>', { noremap = true })

require'treesitter-context'.setup()
require'nvim-web-devicons'.setup{
  default = true
}

require'colorizer'.setup()

require'neogen'.setup({
  snippet_engine = 'luasnip'
})

vim.api.nvim_set_keymap("n", "<leader>nc", ":Neogen<CR>", { noremap = true, silent = true })

-- @Fixme can't make it work yet
require'fzf-lua'.setup({
  previewers = {
    git_diff = {
      pager = "delta",
    }
  },
  winopts = {
    split = "belowright new",
    preview = {
      hidden = "hidden",
    }
  },
})

function zen_mode()
  -- Toggle line numbers, gitsigns and indentblankline
  print("This is zen mode")
end

vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua files <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fo', ':FzfLua oldfiles <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':FzfLua buffers <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fw', ':FzfLua grep_cword <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fk', ':FzfLua live_grep_native <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':FzfLua grep <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fs', ':FzfLua lsp_document_symbols <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fi', ':FzfLua git_files <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fgc', ':FzfLua git_commits <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fgb', ':FzfLua git_branches <CR>', { noremap = true })


-- Shut down sometings
vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua zen_mode()<CR>', { noremap = true})
