-- File:   cmp.lua
-- Author: Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--	Keybind functions for the cmp completion plugin. Are used in conf.lua

local cmp = require('cmp')


local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
end


local M = {}

-- Keybindings:
--
-- i_(S-)Tab  when completion menu is visible insert next/prev entry, else jump to next/prev snippet tag
-- c_(S-)Tab  when completion menu is visible insert next/prev entry, else starts completion
-- i_CR       when completion menu is visible select completion or expand snippet, else <CR>
-- c_CR       when completion menu is visible select completion only, don't accept line, else <CR> (accept line)
-- i_CTRL_n/p when completion menu is visible, select next/prev completion item, else <C-n>/<C-p>
-- c_CTRL_n/p when completion menu is visible, select next/prev completion item, else filter history

M.TAB = {}
function M.TAB.c()
        if cmp.visible() then
                -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                cmp.select_next_item()
        else
                cmp.complete()
        end
end

function M.TAB.s(fallback)
        if cmp.visible() then
                -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                cmp.select_next_item()
        else
                fallback()
        end
end

function M.TAB.i(fallback)
        if cmp.visible() then
                -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                cmp.select_next_item()
        else
                fallback()
        end
end

M.S_TAB = {}
function M.S_TAB.c()
        if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
                cmp.complete()
        end
end

function M.S_TAB.i(fallback)
        if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
                fallback()
        end
end

function M.S_TAB.s(fallback)
        fallback()
end

M.C_n = {}
function M.C_n.c()
        if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
                vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
end

function M.C_n.i(fallback)
        if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
                fallback()
        end
end

M.C_p = {}
function M.C_p.c()
        if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
                vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
end

function M.C_p.i(fallback)
        if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
                fallback()
        end
end

M.CR = {}
M.CR.i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
function M.CR.c(fallback)
        if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
                fallback()
        end
end

return M
