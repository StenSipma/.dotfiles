" File:   completion.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"	File which configures the completion framework (compe or completion)

" Options:
" Set completeopt to have a better completion experience
" TODO: figure out what the options actually do
set completeopt=menuone,noselect

" Avoid showing message extra message when using completion
" TODO: figure out what the options actually do
" set shortmess+=c

" Enable compe
lua require('compe').setup( require('sten.conf').compe_conf )


" Functions:
lua << EOF
-- Wrapper function to replace termcodes of a given string
-- Useful when 'returning' key sequences from a function (see usage below)
local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                return true
        else
                return false
        end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
                return t "<C-n>"
        elseif check_back_space() then
                return t "<Tab>"
        else
                return vim.fn['compe#complete']()
        end
end

_G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
                return t "<C-p>"
        else
                return t "<S-Tab>"
        end
end

EOF


" General Keybindings:
" Use <Tab> and <S-Tab> to navigate through popup menu
lua << EOF
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" Enable auto importing 
" (the argument to compe#confirm gives the default fallback case. When you are
" using delimitMate, this should be the delimitMateCR function, to keep that
" plugin's function working)
lua << EOF
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<Plug>delimitMateCR")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
EOF
