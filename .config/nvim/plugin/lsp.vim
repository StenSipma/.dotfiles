" File:   lsp.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for all LSP (Language Server Protocol)
"       configurations.

" Set completeopt to have a better completion experience
" TODO: figure out what the options actually do
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" TODO: figure out what the options actually do
set shortmess+=c

" General Keybindings:
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Jump to definition
nnoremap gd        :lua vim.lsp.buf.definition()<CR>
" List references
nnoremap gr        :lua vim.lsp.buf.references()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>  
" Rename on cursor
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>

"command RestartLSP :lua vim.lsp.stop_client(vim.lsp.get_active_clients())

" augroup MY_LSP_GROUP
"         au!
"         autocmd BufWrite *.py :lua vim.lsp.buf.formatting_sync(nil, 1000)
" augroup END

" LSP Server Setups:
" Python (pyls)
"lua require'lspconfig'.pyls.setup( require'configs'.pyls_conf )
" Python (pyright)
lua require'lspconfig'.pyright.setup( require'configs'.pyright_conf )
" Lua (Sumneko_lua)
lua require'lspconfig'.sumneko_lua.setup( require'configs'.lua_conf )
" LaTeX (Texlab)
lua require'lspconfig'.texlab.setup( require'configs'.texlab_conf )
" Rust (rust-analyzer)
lua require'lspconfig'.rust_analyzer.setup( require'configs'.rust_analyzer_conf )
