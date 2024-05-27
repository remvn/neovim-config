return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
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
        keymap.set("n", "<leader>pb", builtin.current_buffer_fuzzy_find, {})
        keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
        keymap.set("n", "<leader>vh", builtin.help_tags, {})
        keymap.set("n", "<leader>lg", builtin.live_grep, {})
        keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        keymap.set("n", "<leader>pw", builtin.grep_string, {})

        -- #lsp-keymap
        keymap.set("n", "gr", builtin.lsp_references, {})
    end,
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local telescopeConfig = require("telescope.config")
        local trouble = require("trouble.providers.telescope")
        local action_state = require("telescope.actions.state")

        local delete_buffer = function(prompt_bufnr)
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            current_picker:delete_selection(function(selection)
                local ok = pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
                return ok
            end)
        end

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
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
                        ["<C-e>"] = trouble.open_with_trouble,
                        ["<M-q>"] = false,
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
            },
            extensions = {},
        })

        telescope.load_extension("fzf")
    end,
}
