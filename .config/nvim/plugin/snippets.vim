" File:   lsp.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for snippets

" let g:completion_enable_snippet = "UltiSnips"

" let g:UltiSnipsExpandTrigger = "<c-l>"
" let g:UltiSnipsSnippetDirectories=[$XDG_CONFIG_HOME . "/nvim/user-snippets"]
" let g:ultisnips_python_style="numpy"
" TODO: Add jump forward and backward keybindings for UltiSnips

imap <silent> <C-l> <Plug>luasnip-expand-snippet
imap <silent> <C-j> <Plug>luasnip-jump-next
inoremap <silent> <C-k> <Cmd>lua require'luasnip'.jump(-1)<Cr>

" Initialize with custom config
lua require("luasnip").config.set_config( require"sten.conf".luasnip_conf )
" Create the actual snippets
lua require("sten.luasnip").init_snippets()

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
" imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
" smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
