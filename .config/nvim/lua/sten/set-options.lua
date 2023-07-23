-- File:   set-options.lua
-- Author: Sten Sipma (sten.sipma@ziggo.nl)
-- Description:
--       (Neo)vim configuration file for all the 'set' settings / options.
--       Each setting is documented, but the vim help contains a lot more info
--       and alternative options for each.  
--       For a list of all options: 
--               :help options

vim.opt.relativenumber = true -- Numbers on the number line are relative to the cursor
vim.opt.nu = true             -- Set the number on the cursor line to the line number
                              -- (instead of 0)

vim.opt.wrap = false  -- Do not wrap the line if it exceeds the window size
vim.opt.scrolloff = 3 -- Scroll window down if cursor is 5 lines above/below the
                      -- edges There exists a similar option for horizontal
                      -- scrolling

vim.opt.ruler = true       -- Display current cursor position in the lower right corner
vim.opt.showcmd = true     -- Display incomplete commands in the lower right corner
vim.opt.wildmenu = true    -- Display command auto complete options as a status bar

vim.opt.splitright = true  -- <Ctrl-w>v splits to the right instead of left

vim.opt.incsearch = true   -- Display match for search pattern whilst typing
vim.opt.ignorecase = true  -- Case insensitive searching (i.e. using /, : etc.)
vim.opt.smartcase = true   -- Make search case sensitive if an upper case letter is used

vim.opt.colorcolumn = "89"     -- Display a vertical line at column 89

vim.opt.tabstop = 4        -- Set the tab size
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4     -- Set the size used for indenting using >>
vim.opt.expandtab = true   -- Expand tabs into spaces
vim.opt.autoindent = true  -- Going to a newline retains the indentation of the current 
                           -- line
vim.opt.smartindent = true -- TODO: testing this option



vim.opt.hidden = true -- Keep unsaved files active even in background (removes the 
		      -- force-save functionality when switching buffers)

--set inccommand=split  -- Show the effects of a command in a separate split
                        -- window. Default displays it in the buffer already,
                        -- so turned off for now.

vim.opt.updatetime=50   -- Time (milliseconds) before the CursorHold event is triggered

-- Backup settings
-- TODO: see which ones I want to have
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true
