-- ................................................................................
-- Code action sign (with virtual text)

local codeaction_icon = ""
local CA_SIGN_NAME = "MyCodeActionSign"
local CA_SIGN_GROUP = "mycodeactionsign"
local CA_SIGN_COLOR = "gray"

vim.cmd("hi MyCodeActionSign guifg=" .. CA_SIGN_COLOR .. " guibg=NONE")

local function get_namespace()
    return vim.api.nvim_create_namespace(CA_SIGN_GROUP)
end

local function indication_virtual_text(bufnr, line)
    local namespace = get_namespace()
    vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
    if not line then return end
    local icon_with_indent = "  " .. codeaction_icon
    vim.api.nvim_buf_set_extmark(bufnr, namespace, line, -1, {
        virt_text = { { icon_with_indent, CA_SIGN_NAME } },
        virt_text_pos = "overlay",
        hl_mode = "combine",
    })
end

local function codeaction_indication(do_clear)
    local bufnr = vim.api.nvim_get_current_buf()
    if do_clear == "clear" then
        return indication_virtual_text(bufnr)
    end
    local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
    local params = vim.lsp.util.make_range_params()
    params.context = context
    local line = params.range.start.line
    vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(_, actions, _)
        if not actions or type(actions) ~= "table" or vim.tbl_isempty(actions) then
            return indication_virtual_text(bufnr)
        else
            return indication_virtual_text(bufnr, line)
        end
    end)
end

local function listener()
    vim.api.nvim_create_augroup("CodeActionIndication", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
        group = "CodeActionIndication",
        pattern = "*.*",
        callback = function() codeaction_indication() end
    })
    vim.api.nvim_create_autocmd("CursorMoved ", {
        group = "CodeActionIndication",
        pattern = "*.*",
        callback  = function() codeaction_indication("clear") end
    })
end

return { listener = listener }

