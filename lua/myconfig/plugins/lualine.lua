return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    {
                        'filename',
                        path = 1,
                        file_status = true,
                    }
                },
                lualine_b = {},
                lualine_c = {},
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
