local languages = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "go",
    "javascript",
    "typescript",
    "html",
    "css",
    "makefile",
    "sql",
}

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "*" },
            desc = "treesitter highlight autocmd",
            callback = function(args)
                local buf, filetype = args.buf, args.match
                local language = vim.treesitter.language.get_lang(filetype)
                if not language or not vim.treesitter.language.add(language) then
                    return
                end

                vim.treesitter.start()
                vim.wo[0][0].foldmethod = 'expr'
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            end,
        })
    end,
}

local textobjects = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        vim.g.no_plugin_maps = true
    end,
    config = function()
        require("nvim-treesitter-textobjects").setup {
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
        }
    end,
}

return {
    treesitter,
    textobjects,
}
