local tabout = require("myconfig.tabout")

-- check :h map-mode for mode alias

vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("x", "il", "^o$h")
keymap.set("o", "il", ":norm vil<CR>", { silent = true })

keymap.set("i", "jk", "<Esc>")
keymap.set("t", "jk", "<C-\\><C-n>") -- terminal
keymap.set("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "Close Neovim" })

-- experimental
keymap.set("n", "cn", "*``cgn")
keymap.set("n", "cN", "*``cgN")
-- store selection in search register and record macro
keymap.set("x", "qi", [[y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>gvqi]])
-- select next match and apply macro
keymap.set("n", "<F8>", "gn@i")

-- jump out of bracket with tab
tabout:set_keymap()

-- git status
keymap.set(
    "n",
    "<leader>gs",
    "<cmd>tabnew<cr><cmd>LualineRenameTab Fugitive  <cr><cmd>G<cr><C-w>K"
)

-- disable some default mappings
keymap.set({ "n", "x" }, "<C-a>", "<nop>")
keymap.set({ "n", "x" }, "<C-x>", "<nop>")

-- split window
keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>")
keymap.set("n", "<leader>hs", "<cmd>split<CR>")
vim.cmd("cnoreabbrev hres resize")
vim.cmd("cnoreabbrev vres vertical resize")

-- tab selection
keymap.set("n", "[t", "<cmd>tabprevious<CR>")
keymap.set("n", "]t", "<cmd>tabnext<CR>")
keymap.set("n", "tq", "<cmd>tabclose<cr>")
vim.cmd("cnoreabbrev tnew tabnew")
vim.cmd("cnoreabbrev tclose tabclose")

-- move selection
keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- fast navigation
keymap.set({ "n", "v" }, "<C-k>", "5k")
keymap.set({ "n", "v" }, "<C-j>", "5j")

-- save with Ctrl S
keymap.set("n", "<C-s>", ":w<CR>")

-- replace the word under cursor globally
keymap.set("n", "<leader>sub", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- paste without yanking in visual mode
keymap.set("x", "<leader>p", [["_dP]])

-- yank line without newline
keymap.set("n", "<leader>yl", "^y$")

-- yank to clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set("n", "<leader>wf", [[ggVG"+y]])

-- remap ^ and $
keymap.set({ "n", "v", "o" }, "<C-h>", "^")
keymap.set({ "n", "v", "o" }, "<C-l>", "$")

-- newline without insert mode
-- MUST use [[ ]] without empty space
keymap.set("n", "<A-j>", 'o<Esc>0"_Dk')
keymap.set("n", "<A-k>", 'O<Esc>0"_Dj')

-- better J
keymap.set("n", "J", "mzJ`z")

-- no yank at x
keymap.set("n", "x", '"_x')

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
        vim.cmd("cclose")
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd("copen")
    end
end
keymap.set("n", "<leader>qf", toggle_qf)
