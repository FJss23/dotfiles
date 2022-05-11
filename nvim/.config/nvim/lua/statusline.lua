-- https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/

local M = {}

function M.statusline()
  local parts = {
    [[%> » %{luaeval("require'statusline'.get_file_icon()")}]],
    [[%> %{luaeval("require'statusline'.file_or_lsp_status()")} %m%r%=]],
    "%#warningmsg#",
    "%{ &ff != 'unix' ? '['.&ff.'] ' : '' }",
    "%*",
    "%#warningmsg#",
    "%{ (&fenc != 'utf-8' &&&fenc != '') ? '['.&fenc.'] ' : '' }",
    "%*",
    "並[%l, %L]  %p ",
    [[%{luaeval("require'statusline'.diagnostic_status()")}]],
  }
  return table.concat(parts, '')
end

function M.get_file_icon()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
  return ' ' .. icon
end

function M.file_or_lsp_status()
  local messages = vim.lsp.util.get_progress_messages()
  local mode = vim.api.nvim_get_mode().mode

  if mode ~= 'n' or vim.tbl_isempty(messages) then
    return M.format_uri(vim.uri_from_bufnr(vim.api.nvim_get_current_buf()))
  end

  local percentage
  local result = {}

  for _, msg in ipairs(messages) do
    if msg.message then
      table.insert(result, msg.title .. ': ' .. msg.message)
    else
      table.insert(result, msg.title)
    end

    if msg.percentage then
      percentage = math.max(percentage or 0, msg.percentage)
    end
  end

  if percentage then
    return string.format('%03d: %s', percentage, table.concat(result, ', '))
  else
    table.concat(result, ', ')
  end

end

function M.format_uri(uri)
  return vim.fn.fnamemodify(vim.uri_to_fname(uri), ':.')
end

function M.diagnostic_status()
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local error_text = ''
  local warning_text = ''

  if num_errors > 0 then
    error_text = '-   Error: ' .. num_errors .. ' '
  end

  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

  if num_warnings > 0 then
    warning_text = '-   Warn: ' .. num_warnings .. ' '
  end

  return warning_text .. error_text
end

return M
