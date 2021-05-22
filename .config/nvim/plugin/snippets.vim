" File:   lsp.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for snippets

let g:completion_enable_snippet = "UltiSnips"

let g:UltiSnipsExpandTrigger = "<c-l>"
let g:UltiSnipsSnippetDirectories=[$XDG_CONFIG_HOME . "/nvim/user-snippets"]
let g:ultisnips_python_style="numpy"
