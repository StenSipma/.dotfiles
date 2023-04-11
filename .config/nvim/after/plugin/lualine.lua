require('lualine').setup {
        options = {
                theme = 'gruvbox-material';
        };

        -- Lualine has sections: [a>b>c     x<y<z]
        sections = {
                lualine_b = {'branch', 'diff'},
                -- lualine_x = {statusline.diagnostic_status, statusline.lsp_status, 'encoding', 'filetype'};
                -- lualine_x = {require'lsp-status'.status, 'encoding', 'filetype'};
                lualine_x = {{'diagnostics', sources={'nvim_diagnostic'}}, 'encoding', 'filetype'};
                lualine_z = {require("sten.statusline").location};
        }
}
