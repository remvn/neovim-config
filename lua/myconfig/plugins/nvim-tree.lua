local plugin = {
    "nvim-tree/nvim-tree.lua",
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
                        border = 'rounded',
                        relative = 'editor',
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
        local nvimTreeFocusOrToggle = function()
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
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
            vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
            vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
            vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
            vim.keymap.set("n", "S", api.tree.search_node, opts "Search") -- TODO what is this?
            vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
            vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
            vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")

            -- filters
            vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
            vim.keymap.set("n", "F", api.live_filter.clear, opts "Clear filter")
            vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Git Clean")
            vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
            -- vim.keymap.set("n", "H", api.tree.toggle_custom_filter, opts "Toggle Hidden")
            -- vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
            -- vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle No Buffer")

            -- basic function
            vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
            vim.keymap.set("n", "<leader>vs", api.node.open.vertical, opts "Open: Vertical Split")
            vim.keymap.set("n", "<leader>hs", api.node.open.horizontal, opts "Open: Horizontal Split")
            vim.keymap.set("n", "a", api.fs.create, opts "Create")
            vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
            vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
            vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
            vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
            vim.keymap.set("n", "D", api.fs.trash, opts "Trash")
            vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
            vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
            vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
            vim.keymap.set("n", "<leader>cd", api.tree.change_root_to_node, opts "CD")
            vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
            vim.keymap.set("n", "q", api.node.open.edit, opts "Open")
            vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
            vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
            vim.keymap.set("n", "<C-c>", api.tree.close, opts "Close tree")
        end

        vim.keymap.set("n", "<C-e>", nvimTreeFocusOrToggle)

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
                custom = { "^\\.git$" }
            },
            git = {
                show_on_dirs = true,
            },
            renderer = {
                highlight_git = true,
                indent_markers = {
                    enable = true,
                    inline_arrows = false
                },
                icons = {
                    git_placement = "after",
                    modified_placement = "after",
                    diagnostics_placement = "signcolumn",
                    bookmarks_placement = "signcolumn",
                    show = {
                        folder_arrow = false,
                    },
                    glyphs = {
                        git = {
                            -- Change type
                            unmerged  = "",
                            deleted   = "",
                            renamed   = "󰁕",
                            -- Status type
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                        },
                    },
                },
            },
            on_attach = on_attach,
        })
    end,
}

return plugin
