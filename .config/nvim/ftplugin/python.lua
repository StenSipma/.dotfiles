-- Enable custom folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.foldexpr()"
vim.wo.foldtext = "v:lua.foldtext()"

vim.b.runprg = "!python3 %"
