" File:   lsp.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for all LSP (Language Server Protocol)
"       and completion framework options.

" Functions:
lua << EOF
function _G.contextual_documentation()
        -- Use the lsp hover if a LSP client is active in the current buffer,
        -- Otherwise use the default 'vim help' command
        lsp_active = vim.lsp.buf_get_clients()
        if #lsp_active > 0 then
                -- Use the fancy LSP hover
                -- require('lspsaga.hover').render_hover_doc()
                vim.lsp.buf.hover()
        else
                -- Jump to help
                cword = vim.fn.expand('<cword>')
                ok = pcall(vim.cmd, 'help ' .. cword)
                if not ok then
                        print(string.format("No help found for '%s'", cword))
                end
        end
end
EOF

" Jump to definition
nnoremap gd         <cmd>lua vim.lsp.buf.definition()<CR>
" List references
nnoremap gr         <cmd>lua vim.lsp.buf.references()<CR>
" Code Action
nnoremap <leader>ca <cmd>Lspsaga code_action<CR>
" vnoremap <leader>ca <cmd><C-u>lua require('lspsaga.codeaction').range_code_action()<CR>
" nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
" Rename on cursor
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
" Hover/query `help` using K
nnoremap K <cmd>lua contextual_documentation()<CR>
nnoremap <leader>d <cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>

" Commands:
command RestartLSP <cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

augroup LSP_HOVER
        autocmd!
        " autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
        " autocmd CursorHold * lua require('lspsaga.hover').render_hover_doc()
        " TODO: The following will jump to the buffer when executed twice
        " autocmd CursorHold * lua vim.lsp.buf.hover()
augroup END

augroup GOLANG
        autocmd!
        autocmd BufRead *.go set colorcolumn=100
        " Run go fmt on the current file on save
        " autocmd BufWritePre *.go !go fmt <afile>
augroup END
" lua << EOF
"         cmp = require('cmp')
"         function optional_diagnositcs()
"                 if not cmp.visible() then

"                 end
"         end
" EOF

" augroup MY_LSP_GROUP
"         au!
"         autocmd BufWrite *.py :lua vim.lsp.buf.formatting_sync(nil, 1000)
" augroup END

" LSP Status:
lua require('lsp-status').config(require('sten.conf').lsp_status_conf)
lua require('lsp-status').register_progress()

" Initialize Saga:
" lua require('lspsaga').init_lsp_saga()

" LSP Server Setups:
" Python (pyls)
" lua require'lspconfig'.pylsp.setup( require'sten.conf'.pylsp_conf )
" Python (pyright)
lua require('lspconfig').pyright.setup( require('sten.conf').pyright_conf )
" Lua (Sumneko_lua)
lua require('lspconfig').sumneko_lua.setup( require('sten.conf').lua_conf )
" LaTeX (Texlab)
lua require('lspconfig').texlab.setup( require('sten.conf').texlab_conf )
" Rust (rust-analyzer)
"lua require('lspconfig').rust_analyzer.setup( require('sten.conf').rust_analyzer_conf )
lua require('rust-tools').setup( require('sten.conf').rust_tools_conf )
" Typescript (tsserver)
lua require('lspconfig').tsserver.setup( require('sten.conf').tsserver_conf )
" Go (gopls)
lua require('lspconfig').gopls.setup( require('sten.conf').gopls_conf )
