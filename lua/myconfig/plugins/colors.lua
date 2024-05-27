-- darcula
-- github-theme
-- tokyonight
-- kagawana
-- monokai
-- ayu
-- gruvbox
-- dracula
-- onedark
-- catppuchin
-- sonokai

return {
    {
        "rktjmp/lush.nvim",
        priority = 1000,
        init = function()
            -- see ../../lush_theme/darcula-solid.lua
            vim.cmd.colorscheme("darcula-solid")
        end,
    },
    -- {
    --     "projekt0n/github-nvim-theme",
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require("github-theme").setup({})
    --
    --         vim.cmd("colorscheme github_dark_dimmed")
    --     end,
    -- },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         vim.cmd.colorscheme("tokyonight")
    --     end,
    -- },
    -- {
    --     "olimorris/onedarkpro.nvim",
    --     priority = 1000, -- Ensure it loads first
    --     config = function()
    --         vim.cmd.colorscheme("onedark")
    --     end
    -- },
    -- {
    --     "navarasu/onedark.nvim",
    --     priority = 1000,
    --     config = function()
    --         require('onedark').setup {
    --             style = 'dark',
    --             diagnostics = {
    --                 darker = false,    -- darker colors for diagnostic
    --                 undercurl = true,  -- use undercurl instead of underline for diagnostics
    --                 background = true, -- use background color for virtual text
    --             },
    --         }
    --         require('onedark').load()
    --     end
    -- },
    -- {
    --     'Mofiqul/vscode.nvim',
    --     priority = 1000,
    --     config = function()
    --         local c = require('vscode.colors').get_colors()
    --         require('vscode').setup({
    --             -- style = 'light'
    --             transparent = false,
    --             italic_comments = true,
    --             underline_links = true,
    --             disable_nvimtree_bg = false,
    --         })
    --         require('vscode').load()
    --     end
    -- },
    -- {
    --     "Mofiqul/dracula.nvim",
    --     priority = 1000,
    --     init = function()
    --         vim.cmd.colorscheme("dracula-soft")
    --     end
    -- },
}
