local plugin = {
    "nvim-tree/nvim-tree.lua",
    -- dir = "~/forks/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local tree = require("nvim-tree")
        local api = require("nvim-tree.api")

        -- view (floating tree)
        local HEIGHT_RATIO = 0.8
        local WIDTH_RATIO = 0.5
        local tree_view = {
            number = true,
            relativenumber = true,
            float = {
                enable = true,
                open_win_config = function()
                    local screen_w = vim.opt.columns:get()
                    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                    local window_w = screen_w * WIDTH_RATIO
                    local window_h = screen_h * HEIGHT_RATIO
                    local window_w_int = math.floor(window_w)
                    local window_h_int = math.floor(window_h)
                    local center_x = (screen_w - window_w) / 2
                    local center_y = ((vim.opt.lines:get() - window_h) / 2)
                        - vim.opt.cmdheight:get()
                    return {
                        border = "rounded",
                        relative = "editor",
                        row = center_y,
                        col = center_x,
                        width = window_w_int,
                        height = window_h_int,
                    }
                end,
            },
            width = function()
                return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
            end,
        }

        -- smart toggle
        local focusOrToggle = function()
            local currentBuf = vim.api.nvim_get_current_buf()
            local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
            if currentBufFt == "NvimTree" then
                api.tree.toggle()
            else
                api.tree.focus()
            end
        end

        -- on attach
        local on_attach = function(bufnr)
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                }
            end

            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.del("n", "<C-x>", { buffer = bufnr })
            vim.keymap.del("n", "<C-e>", { buffer = bufnr })
            vim.keymap.del("n", "<C-k>", { buffer = bufnr })

            vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
            vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
            vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
            vim.keymap.set("n", "q", api.node.open.edit, opts("Open"))
            vim.keymap.set("n", "<C-c>", api.tree.close, opts("Close tree"))
        end

        vim.keymap.set("n", "<C-e>", focusOrToggle)

        tree.setup({
            view = tree_view,
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
                debounce_delay = 50,
                icons = {
                    hint = "H",
                    info = "I",
                    warning = "W",
                    error = "E",
                },
            },
            filters = {
                git_ignored = false,
                custom = { "^\\.git$" },
            },
            git = {
                show_on_dirs = true,
            },
            update_focused_file = {
                enable = true,
            },
            renderer = {
                highlight_git = true,
                indent_markers = {
                    enable = true,
                    inline_arrows = false,
                },
                icons = {
                    git_placement = "after",
                    modified_placement = "after",
                    diagnostics_placement = "signcolumn",
                    bookmarks_placement = "after",
                    show = {
                        folder_arrow = false,
                    },
                    glyphs = {
                        bookmark = "",
                        git = {
                            unmerged = "",
                            deleted = "", -- 
                            renamed = "󰁕", -- 󰁕 
                            untracked = "", -- 
                            unstaged = "", -- 
                            staged = "󰄭",
                            ignored = "",
                        },
                    },
                },
            },
            on_attach = on_attach,
        })
    end,
}

return plugin
