-- TODO: maybe use the customized folding from the old config?
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- For individual languages add the following lines in the fplugin:
--
-- vim.wo.foldexpr = require('sten.folding').foldexpr()
-- vim.wo.foldtext = require('sten.folding').foldtext()

require('sten.folding').setup()

vim.wo.foldmethod = "manual"
--set nofoldenable                     " Disable folding at startup.
