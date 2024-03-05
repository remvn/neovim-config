vim.opt.background  = 'dark'
vim.g.colors_name   = "darcula-custom"

local lush          = require('lush')
local darcula_solid = require('lush_theme.darcula-solid')
local hsl           = lush.hsl


-- Base colors
local c0 = hsl(240, 1, 15)
local c1 = c0.lighten(5)
local c2 = c1.lighten(2)
local c3 = c2.lighten(20).sa(10)
local c4 = c3.lighten(10)
local c5 = c4.lighten(20)
local c6 = c5.lighten(70)
local c7 = c6.lighten(80)


-- Background
local bg     = c0 -- base background #262627
local overbg = c1 -- other backgrounds
local subtle = c2 -- out-of-buffer elements


-- Elements
local fg      = hsl(210, 7, 82)  -- #ced1d4
local visual  = hsl(220, 54, 28) -- visual mode
local comment = hsl(0, 0, 54)    -- comments
local folder  = hsl(202, 9, 57)
local treebg  = hsl(220, 3, 19)
local mid     = c2.lighten(10) -- either foreground or background
local faded   = fg.darken(45)  -- non-important text elements
local pop     = c7

-- primary colors: orange, yellow, white

-- Color palette
local red     = hsl(1, 77, 62)   -- #e95653
local salmon  = hsl(10, 90, 70)  -- #f7856e
local orange  = hsl(27, 61, 50)  -- #cd7832
local yellow  = hsl(37, 100, 71) -- #ffc66b

local green   = hsl(83, 27, 53)  -- #8fa867
local teal    = hsl(150, 40, 50) -- #4db380
local cyan    = hsl(180, 58, 38) -- #299999

local blue    = hsl(215, 80, 67) -- #68a0ee
local purple  = hsl(279, 30, 62) -- #a781bb
local magenta = hsl(310, 40, 70) -- #d194c7


-- GUI options
local bold, italic, underline = 'bold', 'italic', 'underline'

---@diagnostic disable: undefined-global
local spec                    = lush.extends({ darcula_solid }).with(function(inject_functions)
    local sym = inject_functions.sym
    return {
        -- Misc
        DiagnosticError { fg = red },
        markdownCode { fg = purple },
        LspSignatureActiveParameter { bg = visual },
        UfoLineCount { fg = purple },
        CmpItemAbbrMatch { fg = blue },
        CmpItemAbbrMatchFuzzy = { fg = blue },

        -- Common syntax highlight
        Type { fg = orange },
        Visual { bg = visual },    -- Visual mode selection
        VisualNOS { bg = visual }, -- Visual mode selection when Vim is "Not Owning the Selection".

        -- Treesitter
        sym "@type" { fg = blue },
        sym "@type.builtin" { fg = orange },
        sym "@type.definition" { fg = blue },
        sym "@variable.parameter" { fg = fg },
        sym "@variable.builtin" { fg = fg },
        sym "@string.escape" { fg = yellow, gui = "bold" },
        sym "@punctuation.special" { fg = orange },
        sym "@tag.delimiter" { fg = yellow },
        sym "@tag.attribute" { fg = fg },
        sym "@namespace" { fg = green },

        -- Golang
        sym "@punctuation.delimiter.go" { fg = fg },
        sym "@variable.member.go" { fg = purple },

        -- Typescript
        typeScriptEndColons { fg = orange },
        typeScriptCall { fg = fg },
        typeScriptGlobalMethod { fg = yellow },

        -- Markdown
        sym "@markup" { fg = fg },                                        -- For strings considerated text in a markup language.
        sym "@markup.strong" { fg = fg, gui = "bold" },                   -- bold
        sym "@markup.italic" { fg = fg, gui = "italic" },                 -- italic
        sym "@markup.strikethrough" { fg = fg, gui = "strikethrough" },   -- strikethrough text
        sym "@markup.underline" { gui = "underline" },                    -- underlined text

        sym "@markup.heading" { fg = blue, gui = "bold" },                -- titles like: # Example

        sym "@markup.math" { fg = blue },                                 -- math environments (e.g. `$ ... $` in LaTeX)
        sym "@markup.environment" { fg = purple },                        -- text environments of markup languages
        sym "@markup.environment.name" { fg = purple },                   -- text indicating the type of an environment

        sym "@markup.link" { fg = purple },                               -- text references, footnotes, citations, etc.
        sym "@markup.link.url" { fg = purple, gui = "italic,underline" }, -- urls, links and emails

        sym "@markup.raw" { fg = orange },                                -- used for inline code in markdown and for doc in python (""")

        sym "@markup.list" { fg = orange },
        sym "@markup.list.checked" { fg = green },     -- todo notes
        sym "@markup.list.unchecked" { fg = comment }, -- todo notes

        -- Harpoon
        HarpoonActive { fg = 'black', bg = blue },
        HarpoonInactive { fg = fg, bg = overbg },
        HarpoonNumberActive { HarpoonActive, gui = "bold" },
        HarpoonNumberInactive { HarpoonInactive, gui = "bold" },

        -- Nvim-tree
        NvimTreeNormal { fg = fg, bg = bg },
        NvimTreeNormalFloat { fg = fg, bg = bg },
        NvimTreeRootFolder { fg = fg, gui = "bold,italic" },
        NvimTreeModifiedFile { fg = yellow },
        NvimTreeCursorLineNr { fg = faded },
        NvimTreeFolderName { fg = blue },
        NvimTreeFolderIcon { NvimTreeFolderName },

        NvimTreeGitDeletedIcon { fg = red },
        NvimTreeGitDirtyIcon { fg = yellow },
        NvimTreeGitIgnoredIcon { fg = comment },
        NvimTreeGitMergeIcon { fg = purple },
        NvimTreeGitNewIcon { fg = green },
        NvimTreeGitRenamedIcon { fg = orange },
        NvimTreeGitStagedIcon { fg = green },

        NvimTreeGitFolderDeletedHL { NvimTreeFolderName },
        NvimTreeGitFolderDirtyHL { NvimTreeFolderName },
        NvimTreeGitFolderIgnoredHL { fg = comment },
        NvimTreeGitFolderMergeHL { NvimTreeFolderName },
        NvimTreeGitFolderNewHL { NvimTreeFolderName },
        NvimTreeGitFolderRenamedHL { NvimTreeFolderName },
        NvimTreeGitFolderStagedHL { NvimTreeFolderName },

        -- Telescope
        TelescopePromptCounter { fg = fg },
        TelescopeBorder { fg = mid, bg = bg },
        TelescopeTitle { fg = fg },
        TelescopeNormal { bg = bg },
    }
end)

lush(spec)
