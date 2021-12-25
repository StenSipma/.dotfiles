" Sets Okular as the PDF viewer after compilation
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

let b:delimitMate_quotes = "\" ' ` * $"

" Folding powered by Treesitter
set foldmethod=expr
set foldexpr=LuaFoldexpr()
set foldtext=LuaFoldtext()

" Compile
nnoremap <leader>ss :w<CR>:VimtexCompile<CR>
