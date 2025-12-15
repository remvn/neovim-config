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
local ignore_langs = require("lib.set").new()

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local ts = require("nvim-treesitter")
        ts.install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "*" },
            desc = "treesitter highlight autocmd",
            callback = function(args)
                local language = vim.treesitter.language.get_lang(args.match)
                if not language or ignore_langs:has(language) then
                    return
                end

                ---@param buf integer
                ---@param lang string
                local function start(buf, lang)
                    vim.treesitter.start()
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end

                local installed_list = ts.get_installed()
                if not vim.list_contains(installed_list, language) then
                    local available_list = ts.get_available()
                    if vim.list_contains(available_list, language) then
                        ts.install(language):await(function()
                            start(args.buf, language)
                        end)
                    else
                        ignore_langs:add(language)
                        return
                    end
                else
                    start(args.buf, language)
                end
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
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "V",
                },
                include_surrounding_whitespace = false,
            },
        })

        vim.keymap.set({ "x", "o" }, "af", function()
            require("nvim-treesitter-textobjects.select").select_textobject(
                "@function.outer",
                "textobjects"
            )
        end, { desc = "function outer" })
        vim.keymap.set({ "x", "o" }, "if", function()
            require("nvim-treesitter-textobjects.select").select_textobject(
                "@function.inner",
                "textobjects"
            )
        end, { desc = "function innter" })
        vim.keymap.set({ "x", "o" }, "ac", function()
            require("nvim-treesitter-textobjects.select").select_textobject(
                "@class.outer",
                "textobjects"
            )
        end, { desc = "class outer" })
        vim.keymap.set({ "x", "o" }, "ic", function()
            require("nvim-treesitter-textobjects.select").select_textobject(
                "@class.inner",
                "textobjects"
            )
        end, { desc = "class inner" })
    end,
}

return {
    treesitter,
    textobjects,
}
