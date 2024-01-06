vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>")

-- move block of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- fast navigation
vim.keymap.set({ "n", "v" }, "<C-k>", "5k")
vim.keymap.set({ "n", "v" }, "<C-j>", "5j")

-- save with Ctrl S
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- word delete with Ctrl-Backspace or Alt-Backspace
-- vim.keymap.set("i", "<C-h>", "<C-w>")
-- vim.keymap.set("i", "<A-Bs>", "<C-w>")

-- paste with Ctrl V
-- vim.keymap.set("i", "<C-v>", '<Esc>"+pa')

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- comment with Ctrl /
vim.keymap.set("n", "<C-_>", "<Plug>CommentaryLine")
vim.keymap.set("v", "<C-_>", "<Plug>Commentary")

-- format buffer
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- remap ^ and $
vim.keymap.set("n", "<C-h>", "^")
vim.keymap.set("n", "<C-l>", "$")

-- newline without insert mode
vim.keymap.set("n", "<A-k>", "O<Esc>j")
vim.keymap.set("n", "<A-j>", "o<Esc>k")

vim.keymap.set("n", "J", "mzJ`z")

-- no yank at x
vim.keymap.set("n", "x", '"_x')

-- jump out of the bracket
vim.keymap.set("i", "<C-l>", "<C-o>a")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
