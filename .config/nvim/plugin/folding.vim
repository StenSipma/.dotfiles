" File:   folding.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	Configure the folding behavior.
"

function LuaFoldexpr()
        return luaeval('require("sten.folding").foldexpr()')
endfunction

function LuaFoldtext()
        return luaeval('require("sten.folding").foldtext()')
endfunction

" set fillchars=fold:*
set foldmethod=manual

" TODO: Work in progress
" set foldtext=LuaFoldtext()
