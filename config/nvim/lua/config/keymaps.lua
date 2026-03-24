vim.g.mapleader = " "

-- Yank
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n" }, "<leader>Y", [["+Y]])

-- Paste without putting into clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Q", "<nop>")

-- Find and replace
vim.keymap.set("n", "<leader>rc", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Editing
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>")

-- Oil plugin
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>Oil<CR>")
