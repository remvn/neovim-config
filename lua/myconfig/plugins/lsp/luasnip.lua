-- follow this guide to build jsregexp on Windows
-- https://github.com/L3MON4D3/LuaSnip/issues/1190#issuecomment-2171656749
local function buildStr()
    local platform = require("myconfig.platform")
    if platform:isWindows() then
        return "pwsh " .. vim.fn.stdpath("config") .. "/luasnip_jsregexp_build.ps1"
    else
        return "make install_jsregexp"
    end
end

return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = buildStr(),
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        require("luasnip").filetype_extend("javascript", { "jsdoc" })
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
