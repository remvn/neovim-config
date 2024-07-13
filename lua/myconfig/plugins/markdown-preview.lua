return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- install without yarn or npm
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
}
