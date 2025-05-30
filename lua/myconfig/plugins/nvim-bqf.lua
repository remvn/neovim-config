---@diagnostic disable: missing-fields
local plugin = {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
        require("bqf").setup({
            func_map = {
                pscrollup = "<C-u>",
                pscrolldown = "<C-d>",
            },
            preview = {
                auto_preview = false,
                should_preview_cb = function(bufnr, qwinid)
                    local ret = true
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    local fsize = vim.fn.getfsize(bufname)
                    if fsize > 100 * 1024 then
                        -- skip file size greater than 100k
                        ret = false
                    elseif bufname:match("^fugitive://") then
                        -- skip fugitive buffer
                        ret = false
                    end
                    return ret
                end,
            },
        })
    end,
}

return plugin
