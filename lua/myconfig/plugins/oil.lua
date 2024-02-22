local plugin = {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = false,
        })
    end
}
return plugin
