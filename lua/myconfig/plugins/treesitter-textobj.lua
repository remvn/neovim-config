local plugin = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
        textobjects = {
            -- prevent move and swap section add default mapping (?)
            move = { enable = true },
            swap = { enable = true },

            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = { query = "@function.outer", desc = "Select outside function" },
                    ["if"] = { query = "@function.inner", desc = "Select inside function" },
                    ["ac"] = { query = "@class.outer", desc = "Select around class" },
                    ["ic"] = {
                        query = "@class.inner",
                        desc = "Select inner part of a class region",
                    },
                },
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "V",
                },
                include_surrounding_whitespace = false,
            },
        },
    }),
}

return plugin
