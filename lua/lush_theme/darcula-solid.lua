---@diagnostic disable: undefined-global
local lush = require("lush")
local hsl = lush.hsl

local bold, italic, underline = "bold", "italic", "underline"

-- Base colors
local c0 = hsl(240, 1, 15)
local c1 = c0.lighten(5)
local c2 = c1.lighten(2)
local c3 = c2.lighten(20).sa(10)
local c4 = c3.lighten(10)
local c5 = c4.lighten(20)
local c6 = c5.lighten(70)
local c7 = c6.lighten(80)

-- Set base colors
local bg = c0 -- base background
local overbg = c1 -- other backgrounds
local subtle = c2 -- out-of-buffer elements

local fg = hsl(210, 7, 82)
local comment = hsl(0, 0, 54) -- comments
local visual = hsl(220, 54, 28) -- visual mode
local treebg = hsl(220, 3, 19)
local mid = c2.lighten(10) -- either foreground or background
local faded = fg.darken(45) -- non-important text elements
local pop = c7
local conceal = hsl(0, 0, 40)

-- Color palette
local red = hsl(1, 77, 62) -- #e95653
local green = hsl(83, 27, 53) -- #8fa867
local yellow = hsl(37, 100, 71) -- #ffc66b
local orange = hsl(27, 61, 50) -- #cd7832
local teal = hsl(150, 40, 50) -- #4db380
local blue = hsl(215, 80, 67) -- #68a0ee
local purple = hsl(279, 30, 62) -- #a781bb
local salmon = hsl(10, 90, 70) -- #f7856e
local magenta = hsl(310, 40, 70) -- #d194c7
local black = "#000000"

local yellow_dark = "#c6b274"

return lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        Normal({ fg = fg, bg = bg }),
        NormalFloat({ fg = fg, bg = overbg }),
        FloatBorder({ fg = mid }),
        NormalNC({ fg = fg, bg = bg.da(10) }), -- normal text in non-current windows

        Comment({ fg = comment, gui = italic }),
        Whitespace({ fg = mid }), -- 'listchars'
        Conceal({ fg = conceal }),
        NonText({ fg = treebg }), -- characters that don't exist in the text
        SpecialKey({ fg = blue }), -- Unprintable characters: text displayed differently from what it really is

        Cursor({ fg = bg, bg = fg }),
        TermCursor({ fg = bg, bg = fg }),
        ColorColumn({ bg = overbg }),
        CursorColumn({ bg = subtle }),
        CursorLine({ CursorColumn }),
        MatchParen({ fg = pop, bg = mid }),

        LineNr({ fg = faded }),
        CursorLineNr({ fg = orange }),
        SignColumn({ LineNr }),
        VertSplit({ fg = overbg, bg = bg }), -- column separating vertically split windows
        Folded({ fg = comment, bg = overbg }),
        FoldColumn({ LineNr }),

        Pmenu({ bg = overbg }), -- Popup menu normal item
        PmenuSel({ bg = mid }), -- selected item
        PmenuSbar({ Pmenu }), -- scrollbar
        PmenuThumb({ PmenuSel }), -- Thumb of the scrollbar
        WildMenu({ Pmenu }), -- current match in 'wildmenu' completion
        QuickFixLine({ fg = pop }), -- Current |quickfix| item in the quickfix window

        StatusLine({ bg = subtle }),
        StatusLineNC({ fg = faded, bg = overbg }),

        TabLine({ bg = mid }), -- not active tab page label
        TabLineFill({ bg = overbg }), -- where there are no labels
        TabLineSel({ bg = faded }), -- active tab page label

        Search({ fg = bg, bg = yellow }), -- Last search pattern highlighting (see 'hlsearch')
        CurSearch({ fg = black, bg = salmon }),
        IncSearch({ Search }), -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Substitute({ Search }), -- |:substitute| replacement text highlighting

        Visual({ bg = visual }), -- Visual mode selection
        VisualNOS({ bg = visual }), -- Visual mode selection when Vim is "Not Owning the Selection".

        ModeMsg({ fg = fg }), -- 'showmode' message (e.g. "-- INSERT -- ")
        MsgArea({ Normal }), -- Area for messages and cmdline
        MsgSeparator({ fg = orange }), -- Separator for scrolled messages `msgsep` flag of 'display'
        MoreMsg({ fg = green }), -- |more-prompt|
        Question({ fg = green }), -- |hit-enter| prompt and yes/no questions
        ErrorMsg({ fg = red }), -- error messages on the command line
        WarningMsg({ fg = red }), -- warning messages

        Directory({ fg = blue }), -- directory names (and other special names in listings)
        Title({ fg = blue }), -- titles for output from ":set all" ":autocmd" etc.

        DiffAdd({ fg = green.da(20) }),
        DiffDelete({ fg = red }),
        DiffChange({ fg = yellow.da(20) }),
        DiffText({ DiffChange, gui = underline }),

        SpellBad({ fg = red, gui = underline }),
        SpellCap({ fg = magenta, gui = underline }),
        SpellLocal({ fg = orange, gui = underline }),
        SpellRare({ fg = yellow, gui = underline }),

        ---- Language Server Protocol highlight groups ---------------------------------

        LspReferenceText({ bg = mid }), -- highlighting "text" references
        LspReferenceRead({ bg = mid }), -- highlighting "read" references
        LspReferenceWrite({ bg = mid }), -- highlighting "write" references

        DiagnosticError({ fg = red }),
        DiagnosticWarn({ fg = yellow }),
        DiagnosticInfo({ fg = fg }),
        DiagnosticHint({ fg = fg }),
        DiagnosticOk({ fg = green }),

        DiagnosticUnderlineError({ gui = underline }),
        DiagnosticUnderlineWarn({ gui = underline }),
        DiagnosticUnderlineInfo({ gui = underline }),
        DiagnosticUnderlineHint({ gui = underline }),
        DiagnosticUnderlineOk({ gui = underline }),

        ---- Standard highlight groups -------------------------------------------------
        -- See :help group-name

        Constant({ fg = orange }),
        Number({ fg = blue }),
        Float({ Number }),
        Boolean({ Constant }),
        Character({ fg = orange }),
        String({ fg = green }),

        Identifier({ fg = fg }),
        Function({ fg = yellow }),

        Statement({ fg = orange }), -- (preferred) any statement
        Conditional({ Statement }),
        Repeat({ Statement }),
        Label({ Statement }), -- case, default, etc.
        Operator({ fg = fg }),
        Keyword({ Statement }), -- any other keyword
        Exception({ fg = red }),

        PreProc({ fg = orange }), --  generic Preprocessor
        Include({ PreProc }), -- preprocessor #include
        Define({ PreProc }), -- preprocessor #define
        Macro({ PreProc }), -- same as Define
        PreCondit({ PreProc }), -- preprocessor #if, #else, #endif, etc.

        Type({ fg = orange }),
        StorageClass({ fg = magenta }), -- static, register, volatile, etc.
        Structure({ fg = magenta }), -- struct, union, enum, etc.
        Typedef({ Type }),

        Special({ fg = orange }), -- (preferred) any special symbol
        SpecialChar({ Special }), -- special character in a constant
        Tag({ fg = yellow }), -- you can use CTRL-] on this
        Delimiter({ Special }), -- character that needs attention
        SpecialComment({ Special }), -- special things inside a comment
        Debug({ Special }), -- debugging statements

        Underlined({ gui = underline }),
        Bold({ gui = bold }),
        Italic({ gui = italic }),
        Ignore({ fg = faded }), --  left blank, hidden  |hl-Ignore|
        Error({ fg = red }), --  any erroneous construct
        Todo({ gui = bold }), -- anything that needs extra attention

        ---- Treesitter ----------------------------------------------------------------
        -- see: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
        -- for more information

        -- Identifiers
        sym("@variable")({ fg = fg }), -- Any variable name that does not have another highlight
        sym("@variable.builtin")({ Constant }), -- Variable names that are defined by the languages like `this` or `self`.
        sym("@variable.parameter")({ fg = fg }),
        sym("@variable.parameter.builtin")({ Constant }),
        sym("@variable.member")({ fg = purple }),

        sym("@constant")({ Constant }),
        sym("@constant.builtin")({ Constant, gui = italic }), -- constant that are built in the language: `nil` in Lua.
        sym("@constant.macro")({ Constant, gui = bold }), -- constants that are defined by macros: `NULL` in C.

        sym("@module")({ fg = fg }), -- identifiers referring to modules and namespaces.
        sym("@module.builtin")({ fg = fg }), -- identifiers referring to modules and namespaces.
        sym("@label")({ Label }),

        -- Literals
        sym("@string")({ String }),
        sym("@string.documentaion")({ String }),
        sym("@string.regexp")({ Character }),
        sym("@string.escape")({ fg = yellow, gui = bold }),
        sym("@string.special")({ fg = green, gui = italic }), -- other special strings (e.g. dates)
        sym("@string.special.url")({ fg = blue }), -- URIs (e.g. hyperlinks)
        sym("@string.special.symbol")({ fg = green, gui = italic }), -- symbols or atoms
        sym("@string.special.path")({ fg = fg }), -- symbols or atoms

        sym("@character")({ Character }),
        sym("@character.special")({ Character }),

        sym("@boolean")({ Boolean }),
        sym("@number")({ Number }),
        sym("@number.float")({ Float }),

        -- Types
        sym("@type")({ fg = blue }),
        sym("@type.builtin")({ Constant }),
        sym("@type.definition")({ fg = blue }),

        sym("@attribute")({ PreProc }),
        sym("@attribute.builtin")({ PreProc }),
        sym("@property")({ fg = purple }),

        -- Functions
        sym("@function")({ Function }),
        sym("@function.builtin")({ Function }),
        sym("@function.call")({ Function }),
        sym("@function.macro")({ Function }), -- macro defined fuctions: each `macro_rules` in Rust

        sym("@function.method")({ Function }), -- macro defined fuctions: each `macro_rules` in Rust
        sym("@function.method.call")({ Function }), -- macro defined fuctions: each `macro_rules` in Rust

        sym("@constructor")({ fg = fg }), -- For constructor: `{}` in Lua and Java constructors.
        sym("@operator")({ Operator }),

        -- Keywords
        sym("@keyword")({ Keyword }),
        sym("@keyword.function")({ Keyword }),

        -- Punctuation
        sym("@punctuation.delimiter")({ fg = fg }), -- delimiters ie: `.`
        sym("@punctuation.bracket")({ fg = fg }),
        sym("@punctuation.special")({ Delimiter }), -- special symbols (e.g. `{}` in string interpolation)

        -- Comments
        sym("@comment")({ Comment }),

        -- Markup
        sym("@markup")({ fg = fg }), -- For strings considerated text in a markup language.
        sym("@markup.heading")({ fg = blue, gui = "bold" }),
        sym("@markup.strong")({ fg = fg, gui = "bold" }),
        sym("@markup.italic")({ fg = fg, gui = "italic" }),
        sym("@markup.strikethrough")({ fg = fg, gui = "strikethrough" }),
        sym("@markup.underline")({ gui = "underline" }),
        sym("@markup.raw")({ fg = fg }), -- inline code
        sym("@markup.math")({ fg = blue }), -- math environments (e.g. `$ ... $` in LaTeX)
        sym("@markup.environment")({ fg = purple }), -- text environments of markup languages
        sym("@markup.environment.name")({ fg = purple }), -- text indicating the type of an environment
        sym("@markup.link")({ fg = purple }), -- text references, footnotes, citations, etc.
        sym("@markup.link.url")({ fg = purple, gui = "italic,underline" }), -- urls, links and emails
        sym("@markup.list")({ fg = comment }),
        sym("@markup.list.checked")({ fg = green }), -- todo notes
        sym("@markup.list.unchecked")({ fg = comment }), -- todo notes
        markdownCode({ fg = purple }),
        markdownLinkText({ fg = fg }),
        sym("@lsp.type.class.markdown")({}),

        sym("@tag")({ Tag }), -- Tags like html tag names.
        sym("@tag.attribute")({ fg = fg }),
        sym("@tag.delimiter")({ fg = yellow }),

        -- Undefined
        sym("@repeat")({ Repeat }),
        sym("@exception")({ Exception }),
        sym("@annotation")({ PreProc }), -- C++/Dart attributes annotations that can be attached to the code to denote some kind of meta information
        sym("@include")({ PreProc }), -- includes: `#include` in C `use` or `extern crate` in Rust or `require` in Lua.

        -- DEPRECATED
        -- sym("@text")({ fg = fg }),
        -- sym("@text.emphasis")({ fg = fg, gui = italic }),
        -- sym("@text.underline")({ fg = fg, gui = underline }),
        -- sym("@text.strike")({ Comment, gui = underline }),
        -- sym("@text.strong")({ fg = fg, gui = bold }),
        -- sym("@text.title")({ fg = orange }), -- Text that is part of a title
        -- sym("@text.literal")({ String }), -- Literal text
        -- sym("@text.uri")({ fg = green, gui = italic }), -- Any URI like a link or email

        -- Typescript
        sym("@lsp.type.type.typescript")({ fg = blue }),
        sym("@lsp.type.class.typescript")({ fg = blue }),
        sym("@lsp.type.property.typescript")({ fg = purple }),

        -- Misc
        LspSignatureActiveParameter({ bg = visual }),
        UfoLineCount({ fg = purple }),
        BqfPreviewFloat({ bg = bg, blend = 0 }),
        HelpHyperTextJump({ fg = yellow }),

        -- Git
        sym("@string.special.url.gitcommit")({ fg = fg }),
        GitSignsCurrentLineBlame({ fg = comment }),
        LuaLineDiffAdd({ fg = green }),
        LuaLineDiffDelete({ fg = red }),
        LuaLineDiffChange({ fg = yellow }),

        -- Trouble
        TroublePreview({ bg = visual }),

        -- Harpoon
        HarpoonActive({ fg = black, bg = blue }),
        HarpoonInactive({ fg = fg, bg = overbg }),
        HarpoonNumberActive({ HarpoonActive, gui = bold }),
        HarpoonNumberInactive({ HarpoonInactive, gui = bold }),

        -- Cmp
        CmpItemAbbrMatch({ fg = blue }),
        CmpItemAbbrMatchFuzzy({ fg = blue }),
        CmpItemKindMethod({ fg = yellow }),
        CmpItemKindFunction({ fg = yellow }),
        CmpItemKindField({ fg = purple }),
        CmpItemKindProperty({ fg = purple }),
        CmpItemKindSnippet({ fg = salmon }),
        CmpItemKindModule({ fg = green }),
        CmpItemKindVariable({ fg = fg }),
        CmpItemKindText({ fg = fg }),

        -- Nvim-tree
        NvimTreeNormal({ fg = fg, bg = bg }),
        NvimTreeNormalFloat({ fg = fg, bg = bg }),
        NvimTreeRootFolder({ fg = fg, gui = "bold,italic" }),
        NvimTreeModifiedFile({ fg = yellow }),
        NvimTreeCursorLineNr({ fg = faded }),
        NvimTreeFolderName({ fg = blue }),
        NvimTreeFolderIcon({ NvimTreeFolderName }),
        NvimTreeBookmarkIcon({ fg = magenta }),
        NvimTreeIndentMarker({ fg = hsl(204, 3, 32) }),

        NvimTreeGitDeletedIcon({ fg = red }),
        NvimTreeGitDirtyIcon({ fg = yellow }),
        NvimTreeGitIgnoredIcon({ fg = comment }),
        NvimTreeGitMergeIcon({ fg = purple }),
        NvimTreeGitNewIcon({ fg = green }),
        NvimTreeGitRenamedIcon({ fg = orange }),
        NvimTreeGitStagedIcon({ fg = green }),

        NvimTreeGitFolderDeletedHL({ NvimTreeFolderName }),
        NvimTreeGitFolderDirtyHL({ NvimTreeFolderName }),
        NvimTreeGitFolderIgnoredHL({ fg = comment }),
        NvimTreeGitFolderMergeHL({ NvimTreeFolderName }),
        NvimTreeGitFolderNewHL({ NvimTreeFolderName }),
        NvimTreeGitFolderRenamedHL({ NvimTreeFolderName }),
        NvimTreeGitFolderStagedHL({ NvimTreeFolderName }),

        -- Telescope
        TelescopePromptCounter({ fg = fg }),
        TelescopeBorder({ fg = mid, bg = bg }),
        TelescopeTitle({ fg = fg }),
        TelescopeNormal({ bg = bg }),
    }
end)
