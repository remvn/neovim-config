local M = {}

---@class CopyReferenceConfig
---@field register string
---@field use_absolute_path boolean
---@field use_git_root boolean

---@class CopyReferenceOptions
---@field register? string
---@field use_absolute_path? boolean
---@field use_git_root? boolean

---@class CopyReferenceRange
---@field start_line integer
---@field end_line integer

---@type CopyReferenceConfig
M.config = {
    register = "+",
    use_absolute_path = false,
    use_git_root = true,
}

---@param opts? CopyReferenceOptions
---@return nil
function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})

    -- Create command with subcommands
    ---@param args vim.api.keyset.create_user_command.command_args
    vim.api.nvim_create_user_command("CopyReference", function(args)
        local subcommand = args.args:lower()
        if subcommand == "file" then
            M.copy(false)
        elseif subcommand == "line" or subcommand == "" then
            ---@type CopyReferenceRange?
            local range = nil
            if args.range > 0 then
                range = { start_line = args.line1, end_line = args.line2 }
            end
            M.copy(true, range)
        else
            vim.notify("Invalid subcommand. Use 'line' or 'file'", vim.log.levels.ERROR)
        end
    end, {
        nargs = "?",
        range = true,
        complete = function(ArgLead, CmdLine, CursorPos)
            return { "line", "file" }
        end,
        desc = "Copy file reference with optional subcommand (line/file)",
    })
end

---@return string?
local function get_path()
    local path = vim.fn.expand("%:p")
    if path == "" then
        return nil
    end

    if M.config.use_absolute_path then
        return path
    end

    if M.config.use_git_root then
        local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
        if git_root ~= "" and vim.v.shell_error == 0 then
            -- Make path relative to git root
            if path:sub(1, #git_root) == git_root then
                path = path:sub(#git_root + 2) -- Remove git root + slash
            end
        end
    else
        -- Make relative to cwd
        path = vim.fn.fnamemodify(path, ":.")
    end

    return path
end

---@param include_lines? boolean
---@param range? CopyReferenceRange
---@return nil
function M.copy(include_lines, range)
    local path = get_path()
    if not path then
        vim.notify("No file to copy", vim.log.levels.WARN)
        return
    end

    local reference = path
    if include_lines ~= false then
        if range and range.start_line and range.end_line then
            local start_line = math.min(range.start_line, range.end_line)
            local end_line = math.max(range.start_line, range.end_line)
            reference = start_line == end_line and (path .. ":" .. start_line)
                or (path .. ":" .. start_line .. "-" .. end_line)
        else
            reference = reference .. ":" .. vim.fn.line(".")
        end
    end

    vim.fn.setreg(M.config.register, reference)
    vim.notify("Copied: " .. reference)
end

return M
