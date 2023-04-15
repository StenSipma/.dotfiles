-- TODO: maybe use the customized folding from the old config?
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
--set nofoldenable                     " Disable folding at startup.
