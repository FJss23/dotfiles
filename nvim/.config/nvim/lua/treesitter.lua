-- Configuration for nvim-treesitter plugin
  require'nvim-treesitter.configs'.setup {
    autotag = {
      enable = true
    },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
  }
