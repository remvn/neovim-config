local plugin = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
        textobjects = {
            -- prevent move and swap section add default mapping
            move = {
                enable = true,
            },
            swap = {
                enable = true,
            },

            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
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
                    -- You can also use captures from other query groups like `locals.scm`
                    -- ["as"] = {
                    --     query = "@scope",
                    --     query_group = "locals",
                    --     desc = "Select language scope",
                    -- },
                },

                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "V",
                },

                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = false,
            },
        },
    }),
}

return plugin
