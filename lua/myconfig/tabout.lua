local M = {}

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

M.exec = function()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    local arr = { [["]], [[']], "`", ")", "]", "}" }
    local right = vim.api.nvim_replace_termcodes(
        '<right>', true, false, true
    )
    if has_value(arr, char) then
        vim.api.nvim_feedkeys(right, "i", false)
        return true
    end
    return false
end

M.set_keymap = function(self)
    vim.keymap.set("i", "<Tab>", function()
        local tab = vim.api.nvim_replace_termcodes(
            '<tab>', true, false, true
        )
        if self.exec() == false then
            vim.api.nvim_feedkeys(tab, "n", false)
        end
    end)
end

return M
