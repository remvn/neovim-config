return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- install without yarn or npm
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    config = function()
        if vim.fn.has("wsl") then
            vim.api.nvim_exec2(
                [[
                function! MdpOpenPreview(url) abort
                    let l:mdp_browser = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'
                    let l:mdp_browser_opts = '--new-tab'
                    if !filereadable(substitute(l:mdp_browser, '\\ ', ' ', 'g'))
                        let l:mdp_browser = '/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
                        let l:mdp_browser_opts = '--new-tab'
                    endif
                    execute join(['silent! !', l:mdp_browser, l:mdp_browser_opts, a:url])
                    redraw!
                endfunction
                ]],
                { output = false }
            )
            vim.g.mkdp_browserfunc = "MdpOpenPreview"
        end
    end,
}
