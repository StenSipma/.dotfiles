-- File:   copilot.lua
-- Author:  <>
-- Description:
--      File for configuring Github Copilot

require("copilot").setup({
    -- suggestion = { enabled = false },
    -- panel = { enabled = false },

    -- Disallow specific filetypes
    filetypes = {
        tex = false,
    },
})
