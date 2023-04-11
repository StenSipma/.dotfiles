-- File:   statusline.lua
-- Author: Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--	Lua code for the statusline

local M = {}

function M.location()
        return '%l/%L:%c'
end

local function diagnostic_report(diagnostic, char)
        local num_diagnostics = vim.lsp.diagnostic.get_count(0, diagnostic)
        if num_diagnostics > 0 then
                return string.format(" %s %s", char, num_diagnostics)
        else
                return ""
        end
end

function M.lsp_status()
        local clients = vim.lsp.buf_get_clients();
        if vim.tbl_isempty(clients) then
                return ""
        end

        local client = clients[1]
        local err_str = diagnostic_report("Error", "")
        local warn_str = diagnostic_report("Warning", "")
        local info_str = diagnostic_report("Information", "")
        local hint_str = diagnostic_report("Hint", "")
        return ("殺" .. client.name .. err_str .. warn_str .. info_str .. hint_str)
end

function M.diagnostic_status()
        local clients = vim.lsp.buf_get_clients();
        if vim.tbl_isempty(clients) then
                return ""
        end

end

return M
