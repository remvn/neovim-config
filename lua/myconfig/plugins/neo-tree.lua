-- unused plugin
local plugin = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        local opts = { silent = true, noremap = true }
        vim.keymap.set("n", "<C-e>", ":Neotree toggle position=float<Cr>", opts)
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["S"] = "",
                    ["s"] = "",
                    ["<C-c>"] = "close_window",
                    ["E"] = "expand_all_nodes",
                    ["W"] = "close_all_nodes",
                    ["<leader>hs"] = "open_split",
                    ["<leader>vs"] = "open_vsplit",
                }
            }
        })
    end,
}

return {}
