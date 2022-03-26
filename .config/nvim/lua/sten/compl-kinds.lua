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

        -- Specify the source in the menu (stick to three characters for uniform look)
        vim_item.menu = ({
                buffer = "[Buf]",
                path = "[Pth]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                ultisnips = "[Snp]",
                emoji = "[Emj]",
        })[entry.source.name]

        -- If the completion entry is a LaTeX function that represents a
        -- unicode character; display that character (in the item menu)
        -- TODO: it is probably best to add another check for it to only work
        -- within latex files
        local it = entry.completion_item
        if vim.bo.filetype == "tex" and entry.source.name == "nvim_lsp" and it.detail ~= nil and vim.endswith(it.detail, ", built-in") then
                local split = vim.split(it.detail, ", ")

                -- Some options where you want to display the symbol:
                -- vim_item.menu = split[1] -- The menu (also used for the source)
                -- vim_item.info = split[1] -- Info, seems to not be displayed
                -- vim_item.abbr = vim_item.word .. " " .. split[1] -- Append it to the text matching the autocomplete
                vim_item.kind = string.format('%s Symbol', split[1]) -- Show it as a different Kind
        end

        -- local sym = symbols[vim_item.word]
        -- if sym then
        --         vim_item.menu = sym
        -- end
        return vim_item
end

return M
