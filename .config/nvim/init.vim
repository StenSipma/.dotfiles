" File:   init.vim
" Author: Sten Sipma (sten.sipma@ziggo.nl)
" Description:
"      Main Neovim configuration file which includes the Vim Plug installs and
"      some key bindings at the end. This file will be run before all the other
"      files in ./plugin are run.

" Set the leader key to the spacebar. This leader key can be used for
" custom keybindings. Use: <leader> to access this key.
let mapleader=" "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN INSTALLATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uses Vim Plug as a plugin manager. To install, run the following command in
" the terminal:
"
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"
" TODO: add an install script at the beginnig of this file which installs 
"       vim-plug automatically

let local_plug = $HOME .. '/Documents/Projects/NeoVim'

call plug#begin(stdpath("config") . "/vplugged")

        " Auto Completion Linting Formatting:
        " Neovim Configurations for the LSP client
        Plug 'neovim/nvim-lspconfig'
        " Fancier LSP functions
        Plug 'glepnir/lspsaga.nvim'
        " Completion framework
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/cmp-emoji'
        Plug 'kdheepak/cmp-latex-symbols'
        Plug 'hrsh7th/nvim-cmp'

        " Nice symbols for completion menu
        Plug 'onsails/lspkind-nvim'

        " Snippets:
        " Ultisnips snippets engine
        Plug 'SirVer/ultisnips'
        " Actual Snippets
        Plug 'honza/vim-snippets'
        Plug 'quangnguyen30192/cmp-nvim-ultisnips'

	" General:
        " Easy Align
	Plug 'junegunn/vim-easy-align'
        " Window Maximizer (toggle)
        Plug 'szw/vim-maximizer'
        " Git plugin
	"Plug 'jreybert/vimagit'
        " Auto Match Parenthesis, quotes etc.
        Plug 'Raimondi/delimitMate'

        " Treesitter:
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/playground'
        " Sphinx (in general, but also added treesitter queries)
        " Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }

	" Color Themes:
	Plug 'mhartington/oceanic-next' 
        Plug 'morhetz/gruvbox'
        Plug 'sainnhe/gruvbox-material'
	Plug 'tyrannicaltoucan/vim-deep-space'
	Plug 'liuchengxu/space-vim-theme'

        " Statusline:
        Plug 'hoob3rt/lualine.nvim'
        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'nvim-lua/lsp-status.nvim'

        " Fuzzy Finder:
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'

        " Language Tools:
        Plug 'tpope/vim-commentary'
        " Python
        Plug 'jeetsukumaran/vim-pythonsense'
        " Formatter
        Plug 'psf/black', { 'branch': 'stable' }
        "
        Plug 'chrisbra/csv.vim'
        " LaTeX
        Plug 'lervag/vimtex'

        " Local Plugins:
        " (see the local_plug variable for the path)
        Plug (local_plug . '/fits.nvim')
        Plug (local_plug . '/ts-actions')
        "Plug (local_plug . '/lua-playground')

        " Remote Versions:
        " Plug 'StenSipma/fits.nvim'
call plug#end()
" plug#end already sets: 
"       filetype plugin indent on
"       syntax enable
" So we do not need to set these after.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORSCHEME
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('termguicolors')
        set termguicolors
endif

set background=dark " Uses the colours which are better for a dark background
let g:gruvbox_material_background = 'hard'

" Schemes (uncomment one):
"colorscheme OceanicNext
"colorscheme gruvbox
"colorscheme space-vim-theme
"colorscheme deep-space
colorscheme gruvbox-material

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:maximizer_set_default_mapping = 0

" A specific virtual environment is created for neovim:
let g:python3_host_prog = $XDG_CONFIG_HOME . "/pyvirtualenvs/neovim/bin/python"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY BINDINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Insert Mode:
" Alternative exit from insert mode
inoremap fd <esc>

" Make an 'undo' breakpoint (<c-g>u) when this character is typed
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

"" Normal Mode:
" Center the cursor (zz) & unfold current line (zv) after pressing n
nnoremap n nzzzv
nnoremap N Nzzzv

" Make Y behave like D and C
nnoremap Y y$

" Move directly up in the terminal. Only affects movement when lines are
" wrapped around
"nnoremap j gj
"nnoremap k gk
"
" Yank to the clipboard (can be used with movement)
nnoremap <leader>y "+y

" Cylce between buffers with SPC+Tab
" nnoremap <leader><Tab> :bnext<CR>
" Jump to the alternate-file (previously edited file in the window)
" If no alternate file exists, use :bnext instead.
nnoremap <expr> <leader><Tab> expand('#') == '' ? ':bnext<CR>' : '<C-^><CR>'
" nnoremap <leader><Tab> :call AltfileOrNext()<CR>
" nnoremap <leader><Tab> <C-^>
" Get a list of buffers (:ls) and enter a number to go to that buffer.
"nnoremap <leader>b :ls<CR>:b<space>
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

" Save & Source the current file
nnoremap <leader>ss :w<CR>:source %<CR>
" Save & reload the current file
nnoremap <leader>sr :w<CR>:e %<CR>

" Inverse the search highlight (for if you actually want it back)
nnoremap <C-l> :set invhlsearch<CR>
" Toggle between maximizing current window and resoring layout
nnoremap <leader>m :MaximizerToggle!<CR>


"" Visual Mode:
" Yank to the clipboard
xnoremap <leader>c "+y
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Move selected lines up (J) and down (K)
" Move (:m) From the lower part of the selection ('>), one line down (+1) 
" (or up for the K case) .  Then, reselect (gv) and reindent (=) then reselect
" again (gv)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
