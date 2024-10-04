-- Set space as the <leader> key
vim.g.mapleader = " "

-- Alternative exit from insert mode
vim.keymap.set("i", "fd", "<esc>")

-- Make an 'undo' breakpoint (<c-g>u) when this character is typed
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", "<cr>", "<cr><c-g>u")

-- Center the cursor (zz) & unfold current line (zv) after pressing n
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make Y behave like D and C
vim.keymap.set("n", "Y", "y$")

-- Inverse the search highlight (for if you actually want it back)
vim.keymap.set("n", "<C-l>", ":set invhlsearch<CR>")

-- Move selected lines up (J) and down (K)
-- Move (:m) From the lower part of the selection ('>), one line down (+1)
-- (or up for the K case) .  Then, reselect (gv) and reindent (=) then reselect
-- again (gv)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank to the clipboard (can be used with movement)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Paste/delete without contaminating the yank register
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])


-- 'Project / file' Keymaps (all <leader>p)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pr", ":w<CR>:e %<CR>")

local function run_file()
    vim.cmd("write")
    if vim.b.runprg == nil then
        vim.cmd("so %")
    end
    return vim.cmd(vim.b.runprg)
end

-- vim.keymap.set("n", "<leader>ps", ":w<CR>:so %<CR>")
vim.keymap.set("n", "<leader>ps", run_file)


-- Quickfix commands
vim.keymap.set("n", "<leader>qn", ":cnext<CR>")
vim.keymap.set("n", "<leader>qp", ":cprevious<CR>")
