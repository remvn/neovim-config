---@diagnostic disable: missing-fields
return {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
        require("bqf").setup({
            func_map = {
                pscrollup = "<C-u>",
                pscrolldown = "<C-d>",
            },
        })
    end,
}
