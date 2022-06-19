local luasnip = require 'luasnip'
local augroup = vim.api.nvim_create_augroup("luasnip-expand", {clear = true})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = augroup,
    pattern = "*:s",
    callback = function() if luasnip.in_snippet() then return vim.diagnostic.disable() end end
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = augroup,
    pattern = "[is]:n",
    callback = function() if luasnip.in_snippet() then return vim.diagnostic.enable() end end
})

local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
    return ""
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<C-s>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-s>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-d>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-d>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

require("luasnip.loaders.from_vscode").lazy_load({paths = {"./snippets"}})
