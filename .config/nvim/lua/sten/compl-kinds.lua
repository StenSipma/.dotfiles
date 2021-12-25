-- File:   compl-kinds.lua
-- Author: Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--	Gives icons to the different types of completion in the popup menu
--	Taken from https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#completion-kinds

local M = {}

M.kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

-- Prepends the icon from the above list when a completion item is displayed
function M.format(entry, vim_item)
        -- This concatonates the icons with the name of the item kind
        vim_item.kind = string.format('%s %s', M.kind_icons[vim_item.kind], vim_item.kind)

        -- If the completion entry is a LaTeX function that represents a
        -- unicode character; display that character (in the item menu)
        -- TODO: it is probably best to add another check for it to only work
        -- within latex files
        local it = entry.completion_item
        if vim.bo.filetype == "tex" and entry.source.name == "nvim_lsp" and it.detail ~= nil and vim.endswith(it.detail, ", built-in") then
                local split = vim.split(it.detail, ", ")
                vim_item.menu = split[1]
        end

        -- local sym = symbols[vim_item.word]
        -- if sym then
        --         vim_item.menu = sym
        -- end
        return vim_item
end

return M
