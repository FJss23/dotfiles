local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
    if fpath == "" or fpath == "." then return " » " end

    return string.format(" %%<%s/", fpath)
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then return "" end
    return fname .. " "
end

local function lsp()
    local count = {}
    local levels = {errors = "Error", warnings = "Warn", info = "Info", hints = "Hint"}

    for k, level in pairs(levels) do count[k] = vim.tbl_count(vim.diagnostic.get(0, {severity = level})) end

    return " 琢E" .. count["errors"] .. " W" .. count["warnings"] .. " H" .. count["hints"] .. " I" .. count["info"] ..
               ""
end

local function filetype() return "|  " .. string.format("%s ", vim.bo.filetype) end

local function lineinfo()
    if vim.bo.filetype == "alpha" then return "" end
    return "| 並%l,%c %L "
end

local vcs = function()
    local git_info = vim.fn["fugitive#statusline"]()
    if git_info then
        local branch_name = git_info:sub(6, git_info:len() - 2)
        return table.concat {" |  ", branch_name, " "}
    end
    return " | NO VCS"
end

Statusline = {}

Statusline.active = function()
    return table.concat {
        filepath(), filename(), "%m%r", "%=", lsp(), vcs(),
        "%{ &ff != 'unix' ? '['.&ff.'] ' : '' }", filetype(), lineinfo()
    }
end

function Statusline.inactive() return " %F" end

function Statusline.short() return "%#StatusLineC#   NvimTree" end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
