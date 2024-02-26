return {
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = "rktjmp/lush.nvim",
        priority = 1000,
        init = function()
            -- see ../../../colors/darcula-custom.lua
            vim.cmd.colorscheme("darcula-custom")
        end,
    },
    -- {
    --     "navarasu/onedark.nvim",
    --     priority = 1000,
    --     config = function()
    --         -- require('onedark').setup {
    --         --     style = 'warm',
    --         --     diagnostics = {
    --         --         darker = false,    -- darker colors for diagnostic
    --         --         undercurl = true,  -- use undercurl instead of underline for diagnostics
    --         --         background = true, -- use background color for virtual text
    --         --     },
    --         -- }
    --         -- require('onedark').load()
    --     end
    -- },
    -- {
    --     'Mofiqul/vscode.nvim',
    --     priority = 1000,
    --     config = function()
    --         -- local c = require('vscode.colors').get_colors()
    --         -- require('vscode').setup({
    --         --     -- style = 'light'
    --         --     transparent = false,
    --         --     italic_comments = true,
    --         --     underline_links = true,
    --         --     disable_nvimtree_bg = false,
    --         -- })
    --         -- require('vscode').load()
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