vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>")

-- disable some internal keybindings
vim.keymap.set("v", "u", "<nop>")
vim.keymap.set("v", "U", "<nop>")
vim.keymap.set({ "n", "v" }, "<C-a>", "<nop>")
vim.keymap.set({ "n", "v" }, "<C-x>", "<nop>")

-- split window
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)

-- move selection
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- fast navigation
vim.keymap.set({ "n", "v" }, "<C-k>", "5k")
vim.keymap.set({ "n", "v" }, "<C-j>", "5j")

-- save with Ctrl S
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- paste without yanking
vim.keymap.set("x", "<leader>p", [["_dP]])

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

-- better J
vim.keymap.set("n", "J", "mzJ`z")

-- no yank at x
vim.keymap.set("n", "x", '"_x')

-- jump out of the bracket
vim.keymap.set("i", "<C-l>", "<C-o>a")

-- new tmux session
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

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
vim.keymap.set("n", "<leader>qf", toggle_qf)
