-- File:   compl-kinds.lua
-- Author: Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--	Gives icons to the different types of completion in the popup menu
--	Taken from https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#completion-kinds

local M = {}

-- TODO: Snippet does not show the right icon
M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

function M.setup()
        local kinds = vim.lsp.protocol.CompletionItemKind
        for i, kind in ipairs(kinds) do
                -- print(string.format("%s %s has kind %s", i, kind, M.icons[kind]))
                kinds[i] = M.icons[kind] or kind
        end
end

return M
