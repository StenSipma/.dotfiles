-- Enable custom folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.foldexpr()"
vim.wo.foldtext = "v:lua.foldtext()"

-- Assuming we are in the root directory
vim.b.runprg = "!cargo test"
