return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    init = function()
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap
        keymap.set("n", "<C-p>", builtin.find_files, {})
        keymap.set("n", "<leader>pf", builtin.git_files, {})
        keymap.set("n", "<leader>ls", builtin.buffers, {})
        keymap.set("n", "<leader>ps", builtin.current_buffer_fuzzy_find, {})
        keymap.set("n", "<leader>pd", builtin.lsp_document_symbols, {})
        keymap.set("n", "<leader>vh", builtin.help_tags, {})
        keymap.set("n", "<leader>lg", builtin.live_grep, {})
        keymap.set("n", "<leader>pw", function()
            builtin.grep_string({ search = vim.fn.input("Search: ") })
        end)
        keymap.set("v", "<leader>lg", function()
            local vpos = vim.fn.getpos("v")
            local curpos = vim.fn.getcurpos()
            local strings = vim.fn.getregion(vpos, curpos, { type = vim.fn.mode() })
            local text = table.concat(strings, "\n")
            builtin.grep_string({ search = text })
        end, {})
        keymap.set("n", "<leader>ws", function()
            builtin.lsp_workspace_symbols({ query = vim.fn.input("Search: ") })
        end, {})

        -- #lsp-keymap
        keymap.set("n", "gr", builtin.lsp_references, {})
        keymap.set("n", "<leader>wd", builtin.diagnostics, {})
    end,
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local telescopeConfig = require("telescope.config")
        local action_state = require("telescope.actions.state")

        local delete_buffer = function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            current_picker:delete_selection(function(selection)
                local ok = pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
                return ok
            end)
        end

        -- Get default vimgrep_arguments
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
        -- show hidden files and ignore .git folder
        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup({
            defaults = {
                layout_config = {
                    horizontal = { preview_width = 0.45 },
                },
                vimgrep_arguments = vimgrep_arguments,
                mappings = {
                    i = {
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-s>"] = actions.file_split,
                        ["<M-q>"] = false,
                    },
                    n = {
                        ["<C-c>"] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob",
                        "!**/.git/*",
                    },
                },

                buffers = {
                    mappings = {
                        i = { ["<c-d>"] = delete_buffer },
                        n = { ["<c-d>"] = delete_buffer },
                    },
                },

                diagnostics = {
                    initial_mode = "normal",
                },
            },
            extensions = {},
        })

        telescope.load_extension("fzf")
    end,
}
