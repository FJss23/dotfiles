require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = { "javascript", "typescript", "javascriptreact", "typescriptreact", "go", "lua" },
    },
    autotag = { enable = true },
    context_commentstring = {
        enable = true,
    },
    indent = {
        enable = true
    }
})

require('treesitter-context').setup({
    highlight = { enable = true },
    indent = { enable = true }
})

require('telescope').setup({})
require('telescope').load_extension('fzf')

require('colorizer').setup({})

require('nvim-custom-diagnostic-highlight').setup({})

require('nvim-web-devicons').setup({})

require('code_action').listener()

require('lsp')

require('status_line')
