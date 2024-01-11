return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local colors = {
            bg = "#353536",
            file_name = "#ced1d4",
            mode = "#ced1d4",
            branch = "#ced1d4",
            text = "#ced1d4",
            file_type = "#ced1d4",
            location = "#ced1d4",
            progress = "#ced1d4",
        }
        local theme = {
            normal = {
                a = { fg = colors.mode, bg = colors.bg },
                b = { fg = colors.branch, bg = colors.bg },
                c = { fg = colors.file_name, bg = colors.bg },
                x = { fg = colors.file_type, bg = colors.bg },
                y = { fg = colors.progress, bg = colors.bg },
                z = { fg = colors.location, bg = colors.bg },
            },
        }

        require('lualine').setup({
            options = {
                theme = 'auto',
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        file_status = true,
                    }
                },
                lualine_x = {
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
                    },
                    'branch',
                    'filetype',
                    'lsp-status',
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            }
        })
    end
}
