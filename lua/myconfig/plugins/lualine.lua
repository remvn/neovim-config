--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local colors = {
            bg = "#3a3a3b",
            fade = "#898b8d",
            editor_bg = "#303031",
            text = "#d6d9dc",
            -- white     = "#e2e5e9",
            white = "#ffffff",
            black = "#000000",
            green = "#9db871",
            orange = "#e18437",
            gray = "#adadb1",
            yellow = "#ffcf6b",
        }

        local default = { fg = colors.text, bg = colors.bg }
        local theme = {
            normal = {
                a = default,
                b = default,
                c = default,
                x = default,
                y = { fg = colors.fade, bg = colors.editor_bg },
                z = { fg = colors.black, bg = colors.gray },
            },
            insert = {
                y = { fg = colors.green, bg = colors.editor_bg },
                z = { fg = colors.black, bg = colors.green },
            },
            visual = {
                y = { fg = colors.orange, bg = colors.editor_bg },
                z = { fg = colors.black, bg = colors.orange },
            },
            command = {
                y = { fg = colors.white, bg = colors.editor_bg },
                z = { fg = colors.black, bg = colors.white },
            },
        }

        local tabs = {
            "tabs",
            max_length = 120,
            mode = 2,
            tabs_color = {
                active = "lualine_z_insert", -- Color for active tab.
                inactive = "lualine_a_inactive", -- Color for inactive tab.
            },
            symbols = {
                modified = " [+]", -- Text to show when the file is modified.
            },
        }

        local filename = {
            "filename",
            path = 1,
            file_status = true,
        }

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            -- symbols = { error = " ", warn = " ", hint = " ", info = " ", },
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
        }

        local diff = { "diff" }
        local branch = { "branch", icon = "" }
        local filetype = { "filetype" }

        local lsp_status = {
            "lspstatus",
            icon = {
                "󰌵",
                color = { fg = colors.yellow },
            },
            fmt = trunc(120, 4, 60, false),
        }

        local progress = { "progress" }
        local location = { "location" }

        require("lualine").setup({
            options = {
                theme = theme,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            tabline = {
                lualine_a = {
                    tabs,
                },
            },
            sections = {
                lualine_a = {
                    filename,
                    diagnostics,
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {
                    diff,
                    branch,
                    filetype,
                    lsp_status,
                },
                lualine_y = { progress },
                lualine_z = { location },
            },
        })

        vim.opt.showtabline = 1
    end,
}
