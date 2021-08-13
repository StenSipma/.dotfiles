" File:   lsp.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"       (Neo)vim configuration file for all LSP (Language Server Protocol)
"       and completion framework options.

" Functions:
lua << EOF
function _G.contextual_documentation()
        -- Use the lsp hover if a LSP client is active in the current buffer, 
        -- otherwise use the 'standard' vim help for the word under the cursor.
        lsp_active = vim.lsp.buf_get_clients()
        if #lsp_active > 0 then
                -- Use the fancy LSP hover
                -- require('lspsaga.hover').render_hover_doc()
                vim.lsp.buf.hover()
        else
                -- Jump to help
                cword = vim.fn.expand('<cword>')
                vim.cmd('help ' .. cword)
        end 
end
EOF

" Jump to definition
nnoremap gd         <cmd>lua vim.lsp.buf.definition()<CR>
" List references
nnoremap gr         <cmd>lua vim.lsp.buf.references()<CR>
" Code Action
nnoremap <leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <leader>ca <cmd><C-u>lua require('lspsaga.codeaction').range_code_action()<CR>
"nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>  
" Rename on cursor
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
" Hover/query `help` using K
nnoremap K <cmd>lua contextual_documentation()<CR>

" Commands:
command RestartLSP <cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>

augroup LSP_HOVER
        autocmd!
        " autocmd CursorHold * lua require('lspsaga.hover').render_hover_doc()
        " autocmd CursorHold * lua vim.lsp.buf.hover()
augroup END

" augroup MY_LSP_GROUP
"         au!
"         autocmd BufWrite *.py :lua vim.lsp.buf.formatting_sync(nil, 1000)
" augroup END

" LSP Status:
lua require('lsp-status').config(require('sten.conf').lsp_status_conf)
lua require('lsp-status').register_progress()

" Initialize Saga:
lua require('lspsaga').init_lsp_saga()

" Initialize Completion Kind Icons:
lua require('sten.compl-kinds').setup()

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
lua require('lspconfig').rust_analyzer.setup( require('sten.conf').rust_analyzer_conf )
