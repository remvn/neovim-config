return {
    "sindrets/diffview.nvim",
    config = function()
        local actions = require("diffview.actions")

        local focusEntry = {
            "n",
            "dv",
            actions.focus_entry,
            { desc = "Focus right diffsplit of entry under cursor" },
        }

        require("diffview").setup({
            file_panel = {
                win_config = function()
                    local editor_height = vim.o.lines
                    return { -- See ':h diffview-config-win_config'
                        position = "top",
                        width = editor_height / 2,
                        win_opts = {},
                    }
                end,
            },
            keymaps = {
                file_panel = { focusEntry },
                file_history_panel = { focusEntry },
            },
        })
    end,
}
