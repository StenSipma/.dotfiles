" File:   folding.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Configure the folding behavior.
"

function LuaFoldexpr()
        return luaeval('require("sten.folding").foldexpr()')
endfunction

" TODO: move to Python ftplugin
set foldmethod=expr
set foldexpr=LuaFoldexpr()
