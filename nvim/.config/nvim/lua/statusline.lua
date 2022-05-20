-- https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/

-- local M = {}

-- function M.statusline()
--   local parts = {
--     [[%> » %{luaeval("require'statusline'.get_file_icon()")}]],
--     [[%> %{luaeval("require'statusline'.file_or_lsp_status()")} %m%r%=]],
--     "%#warningmsg#",
--     "%{ &ff != 'unix' ? '['.&ff.'] ' : '' }",
--     "%*",
--     "%#warningmsg#",
--     "%{ (&fenc != 'utf-8' &&&fenc != '') ? '['.&fenc.'] ' : '' }",
--     "",
--     [[%{luaeval("require'statusline'.git_branch()")}]],
--     "%*",
--     "並[%l, %L]  %p ",
--     [[%{luaeval("require'statusline'.diagnostic_status()")}]],
--   }
--   return table.concat(parts, '')
-- end

-- function M.get_file_icon()
--   local filename = vim.fn.expand("%:t")
--   local extension = vim.fn.expand("%:e")
--   local icon = require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
--   return ' ' .. icon
-- end

-- function M.file_or_lsp_status()
--   local messages = vim.lsp.util.get_progress_messages()
--   local mode = vim.api.nvim_get_mode().mode

--   if mode ~= 'n' or vim.tbl_isempty(messages) then
--     return M.format_uri(vim.uri_from_bufnr(vim.api.nvim_get_current_buf()))
--   end

--   local percentage
--   local result = {}

--   for _, msg in ipairs(messages) do
--     if msg.message then
--       table.insert(result, msg.title .. ': ' .. msg.message)
--     else
--       table.insert(result, msg.title)
--     end

--     if msg.percentage then
--       percentage = math.max(percentage or 0, msg.percentage)
--     end
--   end

--   if percentage then
--     return string.format('%03d: %s', percentage, table.concat(result, ', '))
--   else
--     table.concat(result, ', ')
--   end

-- end

-- function M.format_uri(uri)
--   return vim.fn.fnamemodify(vim.uri_to_fname(uri), ':.')
-- end

-- function M.diagnostic_status()
--   local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--   local error_text = ''
--   local warning_text = ''

--   if num_errors > 0 then
--     error_text = '-   Error: ' .. num_errors .. ' '
--   end

--   local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

--   if num_warnings > 0 then
--     warning_text = '-   Warn: ' .. num_warnings .. ' '
--   end

--   return warning_text .. error_text
-- end

-- -- https://www.reddit.com/r/neovim/comments/upe3xx/minimalist_lua_global_statusline_nvim_07_apis_lsp/
-- function M.git_branch()
--   local git_branch = ''
--   if vim.fn.isdirectory '.git' ~= 0 then
--     local branch = vim.fn.system "git branch --show-current | tr -d '\n'"
--     git_branch = ' [' .. branch .. '] '
--   end

--   return git_branch
-- end

-- return M




-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- local modes = {
--   ["n"] = "NORMAL",
--   ["no"] = "NORMAL",
--   ["v"] = "VISUAL",
--   ["V"] = "VISUAL LINE",
--   [""] = "VISUAL BLOCK",
--   ["s"] = "SELECT",
--   ["S"] = "SELECT LINE",
--   ["i"] = "INSERT",
--   [""] = "SELECT BLOCK",
--   ["ic"] = "INSERT",
--   ["R"] = "REPLACE",
--   ["Rv"] = "VISUAL REPLACE",
--   ["c"] = "COMMAND",
--   ["cv"] = "VIM EX",
--   ["ce"] = "EX",
--   ["r"] = "PROMPT",
--   ["rm"] = "MOAR",
--   ["r?"] = "CONFIRM",
--   ["!"] = "SHELL",
--   ["t"] = "TERMINAL",
-- }

-- local function mode()
--   local current_mode = vim.api.nvim_get_mode().mode
--   return string.format(" %s ", modes[current_mode]):upper()
-- end

-- local function update_mode_colors()
--   local current_mode = vim.api.nvim_get_mode().mode
--   local mode_color = "%#StatusLineAccent#"
--   if current_mode == "n" then
--       mode_color = "%#StatuslineAccent#"
--   elseif current_mode == "i" or current_mode == "ic" then
--       mode_color = "%#StatuslineInsertAccent#"
--   elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
--       mode_color = "%#StatuslineVisualAccent#"
--   elseif current_mode == "R" then
--       mode_color = "%#StatuslineReplaceAccent#"
--   elseif current_mode == "c" then
--       mode_color = "%#StatuslineCmdLineAccent#"
--   elseif current_mode == "t" then
--       mode_color = "%#StatuslineTerminalAccent#"
--   end
--   return mode_color
-- end

local function filepath()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
  -- return ' » ' .. icon
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return " »  " .. icon .. " " .. string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "  " .. count["errors"] .. " "
  end
  if count["warnings"] ~= 0 then
    warnings = "  " .. count["warnings"] .. " "
  end
  if count["hints"] ~= 0 then
    hints = "  " .. count["hints"] .. " "
  end
  if count["info"] ~= 0 then
    info = "  " .. count["info"] .. " "
  end

  return errors .. warnings .. hints .. info
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat {
     " ",
     added,
     changed,
     removed,
     " ",
     " ",
     git_info.head,
     " ",
  }
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    filepath(),
    filename(),
    "%=",
    lsp(),
    vcs(),
    filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end
-- This is an example of a comment
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
