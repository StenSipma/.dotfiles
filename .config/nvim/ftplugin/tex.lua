-- File:   tex.vim
-- Author:  Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--      Commands to run for a specific LaTeX buffer

-- Specify viewer for Vimtex
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

vim.b.delimitMate_quotes = "\" ' ` * $"

-- Enable custom folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.foldexpr()"
vim.wo.foldtext = "v:lua.foldtext()"

vim.b.runprg = 'VimtexCompile'
