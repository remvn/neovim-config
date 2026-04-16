local M = {}

---@alias CopyFormat "plain"|"mention"|"markdown"

---@class Options
---@field register? string
---@field use_absolute_path? boolean
---@field use_git_root? boolean
---@field format? CopyFormat

---@class Config
---@field register string
---@field use_absolute_path boolean
---@field use_git_root boolean
---@field format CopyFormat

---@class CopyRange
---@field start_line integer
---@field end_line integer

---@type Config
M.config = {
    register = "+",
    use_absolute_path = false,
    use_git_root = true,
    format = "markdown",
}

---@param opts? Options
---@return nil
function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})

    -- Create command with subcommands
    ---@param args vim.api.keyset.create_user_command.command_args
    vim.api.nvim_create_user_command("CopyReference", function(args)
        local subcommand = args.args:lower()

        local use_git_root = M.config.use_git_root
        local use_absolute_path = M.config.use_absolute_path
        if subcommand == "absolute" then
            use_absolute_path = true
        elseif subcommand == "relative" then
            use_absolute_path = false
        elseif subcommand == "" then
            use_absolute_path = M.config.use_absolute_path
        else
            vim.notify("Invalid subcommand. Use 'absolute' or 'relative'", vim.log.levels.ERROR)
            return
        end

        ---@type CopyRange?
        local range = nil
        if args.range > 0 then
            range = { start_line = args.line1, end_line = args.line2 }
        end
        M.copy({
            format = M.config.format,
            use_git_root = use_git_root,
            use_absolute_path = use_absolute_path,
            range = range,
        })
    end, {
        nargs = "?",
        range = true,
        complete = function(ArgLead, CmdLine, CursorPos)
            return { "absolute", "relative" }
        end,
        desc = "Copy file reference with optional subcommand (absolute/relative)",
    })
end

---@param value string
---@param format CopyFormat
---@return string
local function apply_format(value, format)
    if format == "mention" then
        return "@" .. value
    end
    if format == "markdown" then
        return "`" .. value .. "`"
    end
    return value
end

---@param use_absolute_path boolean
---@param use_git_root boolean
---@return string?
local function get_path(use_absolute_path, use_git_root)
    local path = vim.fn.expand("%:p")
    if path == "" then
        return nil
    end

    if use_absolute_path then
        return path
    end

    if use_git_root then
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

---@class CopyParams
---@field range? CopyRange
---@field use_absolute_path boolean
---@field use_git_root boolean
---@field format CopyFormat

---@param params CopyParams
---@return nil
function M.copy(params)
    local path = get_path(params.use_absolute_path, params.use_git_root)
    if not path then
        vim.notify("No file to copy", vim.log.levels.WARN)
        return
    end

    local range = params.range
    local reference = path
    if range ~= nil then
        if range and range.start_line and range.end_line then
            local start_line = math.min(range.start_line, range.end_line)
            local end_line = math.max(range.start_line, range.end_line)

            if M.config.format == "mention" then
                reference = start_line == end_line and (path .. "#" .. start_line)
                    or (path .. "#" .. start_line .. "-" .. end_line)
            else
                reference = start_line == end_line and (path .. ":" .. start_line)
                    or (path .. ":" .. start_line .. "-" .. end_line)
            end
        end
    end
    reference = apply_format(reference, params.format)

    vim.fn.setreg(M.config.register, reference)
    vim.notify("Copied: " .. reference)
end

return M
