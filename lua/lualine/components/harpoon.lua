local M = require('lualine.component'):extend()
local harpoon = require('harpoon')

local modules = require('lualine_require').lazy_require {
    highlight = 'lualine.highlight',
    utils = 'lualine.utils.utils',
}

M.init = function(self, options)
    if not options.icon then
        options.icon = "Alt"
    end
    M.super.init(self, options)
end

M.update_status = function(self)
    local contents = {}
    local marks_length = harpoon:list():length()
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    for index = 1, marks_length do
        local harpoon_file_path = harpoon:list():get(index).value
        local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ':t')

        local mappings = { "q", "w", "a", "s" }

        if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#HarpoonNumberActive# %s %%#HarpoonActive#%s ", mappings[index] or "?",
                file_name)
        else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s %%#HarpoonInactive#%s ", mappings[index] or "?",
                file_name)
        end
    end

    return table.concat(contents)
end

return M
