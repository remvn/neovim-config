local preinstall = {
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
    "make",
    "sql",
}

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
    -- check if parser exists and load it
    if not vim.treesitter.language.add(language) then
        return false
    end
    -- enables syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- enables treesitter based folds
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- ensure folds are open to begin with
    vim.o.foldlevel = 99

    -- enables treesitter based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    return true
end

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local nvim_treesitter = require("nvim-treesitter")
        nvim_treesitter.install(preinstall)

        local installable_parsers = nvim_treesitter.get_available()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf, filetype = args.buf, args.match
                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end

                if not treesitter_try_attach(buf, language) then
                    if vim.tbl_contains(installable_parsers, language) then
                        -- not already installed, so try to install them via nvim-treesitter if possible
                        nvim_treesitter.install(language):await(function()
                            treesitter_try_attach(buf, language)
                        end)
                    end
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
