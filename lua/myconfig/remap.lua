vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex)
keymap.set("i", "jk", "<Esc>")

-- disable some internal keybindings
keymap.set("v", "u", "<nop>")
keymap.set("v", "U", "<nop>")
keymap.set({ "n", "v" }, "<C-a>", "<nop>")
keymap.set({ "n", "v" }, "<C-x>", "<nop>")

-- split window
keymap.set("n", "<leader>vs", vim.cmd.vsplit)
keymap.set("n", "<leader>hs", vim.cmd.split)

-- move selection
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- fast navigation
keymap.set({ "n", "v" }, "<C-k>", "5k")
keymap.set({ "n", "v" }, "<C-j>", "5j")

-- save with Ctrl S
keymap.set("n", "<C-s>", ":w<CR>")

-- paste without yanking
keymap.set("x", "<leader>p", [["_dP]])

-- yank to clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- comment with Ctrl /
keymap.set("n", "<C-_>", "<Plug>CommentaryLine")
keymap.set("v", "<C-_>", "<Plug>Commentary")

-- format buffer
-- keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- remap ^ and $
keymap.set("n", "<C-h>", "^")
keymap.set("n", "<C-l>", "$")

-- newline without insert mode
keymap.set("n", "<A-k>", "O<Esc>j")
keymap.set("n", "<A-j>", "o<Esc>k")

-- better J
keymap.set("n", "J", "mzJ`z")

-- no yank at x
keymap.set("n", "x", '"_x')

-- jump out of the bracket
keymap.set("i", "<C-l>", "<C-o>a")

-- new tmux session
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

local function toggle_qf()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end
keymap.set("n", "<leader>qf", toggle_qf)
