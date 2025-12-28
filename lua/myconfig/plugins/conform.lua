---@diagnostic disable: redundant-return-value, missing-return-value
local plugin = {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        local conform = require("conform")
        local prettier = { "prettier" }
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                toml = { "taplo" },
                javascript = prettier,
                typescript = prettier,
                yaml = prettier,
                vue = prettier,
                html = prettier,
                svelte = prettier,
                css = prettier,
                scss = prettier,
                c = { "clang-format" },
            },
            format_after_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { async = true, lsp_format = "fallback" }
            end,
            -- format_on_save = function(bufnr)
            --     if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            --         return
            --     end
            --     return { timeout_ms = 2500, lsp_format = "fallback" }
            -- end,
        })
    end,
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

return plugin
