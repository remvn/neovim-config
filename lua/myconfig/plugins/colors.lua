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
}
