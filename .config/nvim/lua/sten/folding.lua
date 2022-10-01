-- File:   folding.lua
-- Author: Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--	Functions for evaluating the fold locations
local M = {}

local ts_utils = require('nvim-treesitter.ts_utils')
local ts = vim.treesitter

local fold_queries = {}
fold_queries.python = [[
        (function_definition) @fold
        (class_definition) @fold

        (block (expression_statement (string) @fold ))
]]

fold_queries.go = [[
        (function_declaration) @fold
        (method_declaration) @fold
        (type_declaration) @fold
        (import_declaration) @fold
]]

fold_queries.rust = [[
        (mod_item) @fold
        (function_item) @fold
]]

fold_queries.tex = [[
        (section) @fold
]]

-- Some options (?)
local fold_query = [[
        (function_definition) @fold
        (class_definition) @fold

        (block (expression_statement (string) @fold ))
]]

local offset = 1;

function M.buf_foldlevels(buf)
        local foldlvl = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        for i, _ in ipairs(foldlvl) do
                foldlvl[i] = 0
        end
        local parser = ts.get_parser()
        local tree = parser:parse()[1]
        local filetype = vim.bo.filetype
        local query = ts.parse_query(filetype, fold_queries[filetype])
        -- local query = ts.parse_query("python", "(function_definition) @fold")

        for _, node, _ in query:iter_captures(tree:root(), buf) do
                local r1, _, r2, _ = node:range()
                for i = r1+1+offset, r2+1, 1 do
                        foldlvl[i] = foldlvl[i] + 1
                end
        end

        return foldlvl
end

M.fold_levels = ts_utils.memoize_by_buf_tick(M.buf_foldlevels, {})

function M.foldexpr()
        if fold_queries[vim.bo.filetype] == nil then
                return 0
        end

        local line = vim.v.lnum
        local buf = vim.api.nvim_get_current_buf()
        return M.fold_levels(buf)[line]
end

function M.foldtext()
        local fold_start = vim.v.foldstart
        local fold_end = vim.v.foldend
        local fold_dashes = vim.v.folddashes
        local fold_level = vim.v.foldlevel

        local fold_size = fold_end - fold_start

        local preview = vim.api.nvim_buf_get_lines(0, fold_start-1, fold_start, nil)

        return string.format("  +%s (%s) :: %s ", fold_dashes, fold_size, preview[1])
        -- return string.format("%s - %s - %s - %s", fold_start, fold_end, fold_dashes, fold_level)
end

return M
