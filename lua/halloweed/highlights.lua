local util = require("halloweed.util")

local M = {}

-- Main function to apply highlights
function M.setup(colors, cfg)
    -- Helper table to simplify applying foreground colors
    local colors_helper = {
        Fg = { fg = colors.fg },
        LightGrey = { fg = colors.light_grey },
        Grey = { fg = colors.gray },
        Red = { fg = colors.red },
        Cyan = { fg = colors.cyan },
        Yellow = { fg = colors.yellow }, 
        Orange = { fg = colors.orange },
        Green = { fg = colors.green },
        Blue = { fg = colors.blue },
        Purple = { fg = colors.purple },
        Black = { fg = colors.black },

        --        in colors
        --         bg = "#FFFFFF",
        --        bg_inactive = "#FAFAFA",
        --        menu = "#FAFAFA",
        --        beige = "#FEFBEF",
        --        fg = "#5C6773",
        --        red = "#F72B0B",
        --        black = "#2C2C2C",
        --        cyan = "#58C1A6",
        --        orange = "#FF7D1C",
        --        blue = "#5262AD",
        --       green = "#63C82D",
        --        yellow = "#F2AE49",
        --        purple = "#8638E5",
        --        gray = "#F0EFEB",
        --        darker_gray = "#ABB0B6",
        --        lighter_gray = "#F8F8F8",
        --        cursor_lines = "#FFFBFA",

    }

    local hl = {
        langs = {}, -- Language-specific highlights (if any)
        plugins = {}, -- Plugin-specific highlights
    }

    local function vim_highlights(highlights)
        for group_name, group_settings in pairs(highlights) do
            vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,
            group_settings.fg or "none",
            group_settings.bg or "none",
            group_settings.sp or "none",
            group_settings.fmt or "none"))
        end
    end

    -- 🖥️ Editor + Window UI: General user interface elements and core Vim window highlights.
    hl.common = {
        Normal = { fg = colors.fg, bg = colors.bg }, -- Main text and background
        NormalNC = { fg = colors.fg, bg = colors.bg_inactive }, -- Inactive window text and background
        Terminal = { fg = colors.fg, bg = cfg.transparent and "NONE" or colors.bg }, -- Terminal window background
        EndOfBuffer = { fg = cfg.ending_tildes and colors.menu or colors.bg, bg = cfg.transparent and "NONE" or colors.bg }, -- Tildes at the end of the buffer
        FoldColumn = { fg = colors.darker_gray, bg = colors.bg_inactive }, -- Column for fold indicators
        Folded = { fg = colors.gray, bg = cfg.transparent and "NONE" or colors.menu }, -- Folded code lines
        ToolbarLine = { fg = colors.fg }, -- Toolbar line
        Cursor = { bg = colors.blue }, -- Character under the cursor in normal mode
        vCursor = { bg = colors.red }, -- Character under the cursor in visual mode
        iCursor = { bg = colors.green }, -- Character under the cursor in insert mode
        lCursor = { bg = colors.lighter_gray }, -- Character under the cursor in language mode
        CursorIM = { bg = colors.lighter_gray }, -- Character under the cursor in input method mode
        CursorColumn = { bg = colors.cursor_lines }, -- Highlight for the current column
        CursorLine = { bg = colors.cursor_lines }, -- Highlight for the current line
        ColorColumn = { bg = colors.lighter_gray }, -- Highlight for a specific column
        CursorLineNr = { fg = colors.orange, bg = colors.bg_inactive, style = "bold" }, -- Line number of the current line
        LineNr = { fg = colors.gray, bg = colors.bg_inactive }, -- Line numbers (non-current line)
        Conceal = { fg = colors.gray, bg = colors.menu }, -- Concealed text
        Added = { fg = colors.green }, -- Text added (e.g., in diffs)
        Removed = { fg = colors.red }, -- Text removed (e.g., in diffs)
        Changed = { fg = colors.blue }, -- Text changed (e.g., in diffs)
        DiffAdd = { fg = "NONE", bg = colors.diff_add }, -- Background for added lines in diffs
        DiffChange = { fg = "NONE", bg = colors.diff_change }, -- Background for changed lines in diffs
        DiffDelete = { fg = "NONE", bg = colors.diff_delete }, -- Background for deleted lines in diffs
        DiffText = { fg = "NONE", bg = colors.diff_text }, -- Background for changed text within a line in diffs
        DiffAdded = { fg = colors.green }, -- Alias for consistency (foreground for added text)
        DiffChanged = { fg = colors.blue }, -- Alias for consistency (foreground for changed text)
        DiffRemoved = { fg = colors.red }, -- Alias for consistency (foreground for removed text)
        DiffDeleted = { fg = colors.red }, -- Alias for consistency (foreground for deleted text)
        DiffFile = { fg = colors.cyan }, -- File names in diff headers
        DiffIndexLine = { fg = colors.darker_gray }, -- Index lines in diff headers
        Directory = { fg = colors.blue }, -- Directory names
        ErrorMsg = { fg = colors.red, style = "bold" }, -- Error messages in the command line
        WarningMsg = { fg = colors.orange, style = "bold" }, -- Warning messages in the command line
        MoreMsg = { fg = colors.green, style = "bold" }, -- "-- More --" prompt
        CurSearch = { fg = colors.black, bg = colors.orange }, -- Current search match
        IncSearch = { fg = colors.black, bg = colors.orange }, -- Incremental search match
        Search = { fg = colors.black, bg = colors.yellow }, -- All search matches
        Substitute = { fg = colors.black, bg = colors.green }, -- Text replaced by :substitute
        MatchParen = { fg = colors.red, bg = colors.lighter_gray }, -- Matching parenthesis
        NonText = { fg = colors.gray }, -- Non-text characters
        Whitespace = { fg = colors.gray }, -- Visible whitespace characters
        SpecialKey = { fg = colors.gray }, -- Special keys
        Pmenu = { fg = colors.fg, bg = colors.menu }, -- Popup menu
        PmenuSbar = { fg = "NONE", bg = colors.menu }, -- Scrollbar in popup menu
        PmenuSel = { fg = colors.black, bg = colors.orange }, -- Selected item in popup menu
        WildMenu = { fg = colors.black, bg = colors.blue }, -- Wildmenu completion
        PmenuThumb = { fg = "NONE", bg = colors.orange }, -- Scrollbar thumb in popup menu
        Question = { fg = colors.yellow }, -- Questions in the command line
        SignColumn = { fg = colors.fg, bg = colors.bg_inactive }, -- Sign column gutter
        SpellBad = { fg = "NONE", undercurl = true, sp = colors.red }, -- Spelling error (bad word)
        SpellCap = { fg = "NONE", undercurl = true, sp = colors.yellow }, -- Spelling error (capitalization)
        SpellLocal = { fg = "NONE", undercurl = true, sp = colors.blue }, -- Spelling error (local word)
        SpellRare = { fg = "NONE", undercurl = true, sp = colors.purple }, -- Spelling error (rare word)
        StatusLine = { fg = colors.fg, bg = colors.menu }, -- Active status line
        StatusLineTerm = { fg = colors.fg, bg = colors.menu }, -- Active terminal status line
        StatusLineNC = { fg = colors.gray, bg = colors.menu }, -- Inactive status line
        StatusLineTermNC = { fg = colors.gray, bg = colors.menu }, -- Inactive terminal status line
        TabLine = { fg = colors.gray, bg = colors.menu }, -- Tab line (inactive tabs)
        TabLineFill = { fg = colors.gray, bg = colors.menu }, -- Filler for the tab line
        TabLineSel = { fg = colors.fg, bg = colors.lighter_gray, style = "bold" }, -- Selected tab in the tab line
        WinSeparator = { fg = colors.gray }, -- Window separator lines
        VertSplit = { fg = colors.gray }, -- Same as WinSeparator
        Visual = { bg = colors.gray }, -- Visual mode selection background
        VisualNOS = { fg = "NONE", bg = colors.lighter_gray, style = "underline" }, -- Visual mode selection (non-start)
        QuickFixLine = { fg = colors.blue, style = "underline" }, -- Current line in quickfix window
        Debug = { fg = colors.yellow }, -- Debugger highlight
        debugPC = { fg = colors.black, bg = colors.green }, -- Debugger program counter
        debugBreakpoint = { fg = colors.black, bg = colors.red }, -- Debugger breakpoint
        ToolbarButton = { fg = colors.black, bg = colors.blue }, -- Toolbar buttons
        FloatBorder = { fg = colors.gray, bg = colors.menu }, -- Border of floating windows
        NormalFloat = { fg = colors.fg, bg = colors.menu }, -- Normal text in floating windows
        FloatTitle = { fg = colors.purple, style = "bold" }, -- Title of floating windows
        FloatFooter = { fg = colors.gray }, -- Footer of floating windows
    }

    hl.syntax = {
        String = { fg = colors.green, style = cfg.code_style.strings }, -- String literals
        Character = { fg = colors.orange }, -- Character literals
        Number = { fg = colors.orange }, -- Numeric literals
        Float = { fg = colors.orange }, -- Floating-point numbers
        Boolean = { fg = colors.orange }, -- Boolean literals (true, false)
        Type = { fg = colors.purple }, -- Type declarations (e.g., int, class, struct)
        Structure = { fg = colors.purple }, -- Structure definitions
        StorageClass = { fg = colors.purple }, -- Storage class specifiers (e.g., static, extern)
        Identifier = { fg = colors.cyan, style = cfg.code_style.variables }, -- Variable names
        Constant = { fg = colors.orange }, -- User-defined constants
        PreProc = { fg = colors.purple }, -- Preprocessor directives (#include, #define)
        PreCondit = { fg = colors.purple }, -- Preprocessor conditionals (#if, #ifdef)
        Include = { fg = colors.purple }, -- Included files in preprocessor directives
        Keyword = { fg = colors.red, style = cfg.code_style.keywords }, -- Language keywords (e.g., if, for, while)
        Define = { fg = colors.purple }, -- #define directives
        Typedef = { fg = colors.purple }, -- Typedef declarations
        Exception = { fg = colors.red }, -- Exception handling keywords (try, catch)
        Conditional = { fg = colors.red, style = cfg.code_style.keywords }, -- Conditional statements (if, else, switch)
        Repeat = { fg = colors.red, style = cfg.code_style.keywords }, -- Loop constructs (for, while, do)
        Statement = { fg = colors.red }, -- General statements
        Macro = { fg = colors.red }, -- Macro definitions
        Error = { fg = colors.red }, -- Syntax errors
        Label = { fg = colors.yellow }, -- Labels (e.g., goto labels, case labels)
        Special = { fg = colors.yellow }, -- Special characters (e.g., escape sequences)
        SpecialChar = { fg = colors.yellow }, -- Special characters within strings
        Function = { fg = colors.blue, style = cfg.code_style.functions }, -- Function names
        Operator = { fg = colors.orange }, -- Operators (+, -, *, /, ==, etc.)
        Title = { fg = colors.purple }, -- Titles in help files
        Tag = { fg = colors.green }, -- HTML/XML tags
        Delimiter = { fg = colors.lighter_gray }, -- Delimiters (e.g., commas, semicolons)
        Comment = { fg = colors.darker_gray, style = cfg.code_style.comments }, -- Code comments
        SpecialComment = { fg = colors.darker_gray, style = cfg.code_style.comments }, -- Special comments (e.g., `/*! ... */`)
        Todo = { fg = colors.red, bg = colors.yellow, style = cfg.code_style.comments }, -- TODO comments
    }

    -- 🌳 Tree-sitter Highlighting: Highlights based on Tree-sitter's AST parsing, offering more granular control.
    if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
        hl.treesitter = {
            -- nvim-treesitter@0.9.2 and after (modern naming)

            -- CSS specific
            ["@property.css"] = { fg = colors.cyan }, -- CSS properties
            ["@selector.css"] = { fg = colors.blue }, -- CSS selectors
            ["@value.css"] = { fg = colors.green }, -- CSS values
            ["@unit.css"] = { fg = colors.orange }, -- CSS units

            ["@annotation"] = { fg = colors.fg }, -- Annotations (e.g., Java annotations)
            ["@attribute"] = { fg = colors.cyan }, -- Attributes (e.g., Python decorators, C# attributes)
            ["@attribute.typescript"] = { fg = colors.blue }, -- TypeScript specific attributes
            ["@boolean"] = { fg = colors.orange }, -- Boolean literals
            ["@character"] = { fg = colors.orange }, -- Character literals
            ["@comment"] = { fg = colors.darker_gray, style = cfg.code_style.comments }, -- Comments
            ["@comment.todo"] = { fg = colors.red, style = cfg.code_style.comments }, -- TODO comments
            ["@comment.todo.unchecked"] = { fg = colors.red, style = cfg.code_style.comments }, -- Unchecked TODO items
            ["@comment.todo.checked"] = { fg = colors.green, style = cfg.code_style.comments }, -- Checked TODO items
            ["@constant"] = { fg = colors.orange, style = cfg.code_style.constants }, -- Constants
            ["@constant.builtin"] = { fg = colors.orange, style = cfg.code_style.constants }, -- Built-in constants
            ["@constant.macro"] = { fg = colors.orange, style = cfg.code_style.constants }, -- Macro constants
            ["@constructor"] = { fg = colors.purple, style = "bold" }, -- Constructor functions/methods
            ["@diff.add"] = { fg = colors.green }, -- Added lines in diffs
            ["@diff.delete"] = { fg = colors.red }, -- Deleted lines in diffs
            ["@diff.plus"] = { fg = colors.green }, -- Plus sign in diffs
            ["@diff.minus"] = { fg = colors.red }, -- Minus sign in diffs
            ["@diff.delta"] = { fg = colors.blue }, -- Changed lines in diffs
            ["@error"] = { fg = colors.fg }, -- Syntax errors
            ["@function"] = { fg = colors.blue, style = cfg.code_style.functions }, -- Function names
            ["@function.builtin"] = { fg = colors.cyan, style = cfg.code_style.functions }, -- Built-in function names
            ["@function.macro"] = { fg = colors.cyan, style = cfg.code_style.functions }, -- Macro function names
            ["@function.method"] = { fg = colors.blue, style = cfg.code_style.functions }, -- Method names
            ["@keyword"] = { fg = colors.red, style = cfg.code_style.keywords }, -- Keywords
            ["@keyword.conditional"] = { fg = colors.red, style = cfg.code_style.keywords }, -- Conditional keywords (if, else)
            ["@keyword.directive"] = { fg = colors.purple }, -- Directive keywords (e.g., #include)
            ["@keyword.exception"] = { fg = colors.red }, -- Exception keywords (try, catch)
            ["@keyword.function"] = { fg = colors.red, style = cfg.code_style.functions }, -- Function-related keywords
            ["@keyword.import"] = { fg = colors.purple }, -- Import/export keywords
            ["@keyword.operator"] = { fg = colors.red, style = cfg.code_style.keywords }, -- Operator keywords (e.g., 'and', 'or' in Python)
            ["@keyword.repeat"] = { fg = colors.red, style = cfg.code_style.keywords }, -- Repeat keywords (for, while)
            ["@label"] = { fg = colors.yellow }, -- Labels
            ["@markup.emphasis"] = { fg = colors.fg, style = "italic" }, -- Emphasized text (e.g., Markdown *italic*)
            ["@markup.environment"] = { fg = colors.fg }, -- Markup environment
            ["@markup.environment.name"] = { fg = colors.fg }, -- Markup environment name
            ["@markup.heading"] = { fg = colors.orange, style = "bold" }, -- Markup headings
            ["@markup.link"] = { fg = colors.blue }, -- Markup links
            ["@markup.link.url"] = { fg = colors.cyan, style = "underline" }, -- Markup link URLs
            ["@markup.list"] = { fg = colors.red }, -- Markup list items
            ["@markup.math"] = { fg = colors.fg }, -- Markup math blocks
            ["@markup.raw"] = { fg = colors.green }, -- Raw markup (e.g., code blocks)
            ["@markup.strike"] = { fg = colors.fg, style = "strikethrough" }, -- Strikethrough text
            ["@markup.strong"] = { fg = colors.fg, style = "bold" }, -- Strong text (e.g., Markdown **bold**)
            ["@markup.underline"] = { fg = colors.fg, style = "underline" }, -- Underlined text
            ["@module"] = { fg = colors.yellow }, -- Module names
            ["@none"] = { fg = colors.fg }, -- Default text color
            ["@number"] = { fg = colors.orange }, -- Numbers
            ["@number.float"] = { fg = colors.orange }, -- Floating-point numbers
            ["@operator"] = { fg = colors.orange }, -- Operators
            ["@parameter.reference"] = { fg = colors.fg }, -- Parameter references
            ["@property"] = { fg = colors.blue }, -- Object properties/fields
            ["@punctuation.delimiter"] = { fg = colors.fg }, -- Punctuation delimiters
            ["@punctuation.bracket"] = { fg = colors.fg }, -- Punctuation brackets
            ["@string"] = { fg = colors.green, style = cfg.code_style.strings }, -- String literals
            ["@string.regexp"] = { fg = colors.orange, style = cfg.code_style.strings }, -- Regular expression strings
            ["@string.special.symbol"] = { fg = colors.cyan }, -- Special symbols in strings
            ["@tag"] = { fg = colors.purple }, -- Tags (e.g., HTML/XML tags)
            ["@tag.attribute"] = { fg = colors.yellow }, -- Tag attributes
            ["@tag.delimiter"] = { fg = colors.purple }, -- Tag delimiters
            ["@text"] = { fg = colors.fg }, -- Plain text
            ["@note"] = { fg = colors.fg }, -- Notes in markup
            ["@warning"] = { fg = colors.fg }, -- Warnings in markup
            ["@danger"] = { fg = colors.fg }, -- Dangers in markup
            --["@type"] = { fg = colors.purple }, -- Type names
            ["@type.builtin"] = { fg = colors.orange }, -- Built-in type names
            ["@type.property"] = { link = '@type' }, -- Property type names
            ['@type.qualifier'] = { fg = colors.orange },
            ['@lsp.type.namespace'] = { link = '@module' },
            ['@lsp.type.type'] = { link = '@type' },
            ['@lsp.type.class'] = { link = '@type' },
            ['@lsp.type.enum'] = { link = '@type' },
            ['@lsp.type.interface'] = { link = '@type' },
            ['@lsp.type.struct'] = { link = '@variable.member' },
            ['@lsp.type.parameter'] = { fg = colors.purple },
            ['@lsp.type.field'] = { link = '@variable.member' },
            ['@lsp.type.variable'] = { link = '@variable' },
            ['@lsp.type.property'] = { link = '@property' },
            ['@lsp.type.enumMember'] = { link = '@constant' },
            ['@lsp.type.function'] = { link = '@function' },
            ['@lsp.type.method'] = { link = '@function.method' },
            ['@lsp.type.macro'] = { link = '@function.macro' },
            ['@lsp.type.decorator'] = { link = '@function' },
            ['@lsp.mod.constant'] = { link = '@constant' },
            ["@variable"] = { fg = colors.fg, style = cfg.code_style.variables }, -- Variable names
            ["@variable.builtin"] = { fg = colors.orange, style = cfg.code_style.variables }, -- Built-in variable names
            ["@variable.member"] = { fg = colors.yellow }, -- Member variables
            ["@variable.parameter"] = { fg = colors.purple }, -- Function parameters
            ["@markup.heading.1.markdown"] = { fg = colors.red, style = "bold" }, -- Markdown heading level 1
            ["@markup.heading.2.markdown"] = { fg = colors.purple, style = "bold" }, -- Markdown heading level 2
            ["@markup.heading.3.markdown"] = { fg = colors.orange, style = "bold" }, -- Markdown heading level 3
            ["@markup.heading.4.markdown"] = { fg = colors.red, style = "bold" }, -- Markdown heading level 4
            ["@markup.heading.5.markdown"] = { fg = colors.purple, style = "bold" }, -- Markdown heading level 5
            ["@markup.heading.6.markdown"] = { fg = colors.orange, style = "bold" }, -- Markdown heading level 6
            ["@markup.heading.1.marker.markdown"] = { fg = colors.red, style = "bold" }, -- Markdown heading 1 marker
            ["@markup.heading.2.marker.markdown"] = { fg = colors.purple, style = "bold" }, -- Markdown heading 2 marker
            ["@markup.heading.3.marker.markdown"] = { fg = colors.orange, style = "bold" }, -- Markdown heading 3 marker
            ["@markup.heading.4.marker.markdown"] = { fg = colors.red, style = "bold" }, -- Markdown heading 4 marker
            ["@markup.heading.5.marker.markdown"] = { fg = colors.purple, style = "bold" }, -- Markdown heading 5 marker
            ["@markup.heading.6.marker.markdown"] = { fg = colors.orange, style = "bold" }, -- Markdown heading 6 marker

            -- Old configuration for nvim-treesitter@0.9.1 and below (for backward compatibility)
            ["@conditional"] = { fg = colors.red, style = cfg.code_style.keywords }, -- Conditional statements
            ["@exception"] = { fg = colors.red }, -- Exception handling
            ["@field"] = { fg = colors.cyan }, -- Field names
            ["@float"] = { fg = colors.orange }, -- Floating-point numbers
            ["@include"] = { fg = colors.purple }, -- Include directives
            ["@method"] = { fg = colors.blue, style = cfg.code_style.functions }, -- Method names
            ["@namespace"] = { fg = colors.purple }, -- Namespace names
            ["@parameter"] = { fg = colors.fg }, -- Function parameters
            ["@preproc"] = { fg = colors.purple }, -- Preprocessor directives
            ["@punctuation.special"] = { fg = colors.red }, -- Special punctuation
            ["@repeat"] = { fg = colors.red, style = cfg.code_style.keywords }, -- Repeat statements
            ["@string.regex"] = { fg = colors.orange, style = cfg.code_style.strings }, -- Regex strings
            ["@string.escape"] = { fg = colors.red, style = cfg.code_style.strings }, -- Escape sequences in strings
            ["@text.strong"] = { fg = colors.fg, style = "bold" }, -- Strong text
            ["@text.emphasis"] = { fg = colors.fg, style = "italic" }, -- Emphasized text
            ["@text.underline"] = { fg = colors.fg, style = "underline" }, -- Underlined text
            ["@text.strike"] = { fg = colors.fg, style = "strikethrough" }, -- Strikethrough text
            ["@text.title"] = { fg = colors.orange, style = "bold" }, -- Text titles
            ["@text.literal"] = { fg = colors.green }, -- Literal text
            ["@text.uri"] = { fg = colors.cyan, style = "underline" }, -- URI text
            ["@text.todo"] = { fg = colors.red, style = cfg.code_style.comments }, -- TODO text
            ["@text.todo.unchecked"] = { fg = colors.red, style = cfg.code_style.comments }, -- Unchecked TODO text
            ["@text.todo.checked"] = { fg = colors.green, style = cfg.code_style.comments }, -- Checked TODO text
            ["@text.math"] = { fg = colors.fg }, -- Math text
            ["@text.reference"] = { fg = colors.blue }, -- Reference text
            ["@text.environment"] = { fg = colors.fg }, -- Text environment
            ["@text.environment.name"] = { fg = colors.fg }, -- Text environment name
            ["@text.diff.add"] = { fg = colors.green }, -- Added text in diffs5c6166
            ["@text.diff.delete"] = { fg = colors.red }, -- Deleted text in diffs        
        }

    else
        -- Fallback for Neovim < 0.8 (older TS naming)
        hl.treesitter = {
            TSAnnotation = { fg = colors.fg }, -- Annotations
            TSAttribute = { fg = colors.cyan }, -- Attributes
            TSBoolean = { fg = colors.orange }, -- Boolean literals
            TSCharacter = { fg = colors.orange }, -- Character literals
            TSComment = { fg = colors.darker_gray, style = cfg.code_style.comments }, -- Comments
            TSConditional = { fg = colors.red, style = cfg.code_style.keywords }, -- Conditional statements
            TSConstant = { fg = colors.orange }, -- Constants
            TSConstBuiltin = { fg = colors.orange }, -- Built-in constants
            TSConstMacro = { fg = colors.orange }, -- Macro constants
            TSConstructor = { fg = colors.purple, style = "bold" }, -- Constructor functions/methods
            TSError = { fg = colors.fg }, -- Syntax errors
            TSException = { fg = colors.red }, -- Exception handling
            TSField = { fg = colors.cyan }, -- Field names
            TSFloat = { fg = colors.orange }, -- Floating-point numbers
            TSFunction = { fg = colors.blue, style = cfg.code_style.functions }, -- Function names
            TSFuncBuiltin = { fg = colors.cyan, style = cfg.code_style.functions }, -- Built-in function names
            TSFuncMacro = { fg = colors.cyan, style = cfg.code_style.functions }, -- Macro function names
            TSInclude = { fg = colors.purple }, -- Include directives
            TSKeyword = { fg = colors.red, style = cfg.code_style.keywords }, -- Keywords
            TSKeywordFunction = { fg = colors.red, style = cfg.code_style.functions }, -- Function-related keywords
            TSKeywordOperator = { fg = colors.red, style = cfg.code_style.keywords }, -- Operator keywords
            TSLabel = { fg = colors.yellow }, -- Labels
            TSMethod = { fg = colors.blue, style = cfg.code_style.functions }, -- Method names
            TSNamespace = { fg = colors.purple }, -- Namespace names
            TSNone = { fg = colors.fg }, -- Default text color
            TSNumber = { fg = colors.orange }, -- Numbers
            TSOperator = { fg = colors.orange }, -- Operators
            TSParameter = { fg = colors.fg }, -- Function parameters
            TSParameterReference = { fg = colors.fg }, -- Parameter references
            TSProperty = { fg = colors.blue }, -- Object properties/fields
            TSPunctDelimiter = { fg = colors.lighter_gray }, -- Punctuation delimiters
            TSPunctBracket = { fg = colors.lighter_gray }, -- Punctuation brackets
            TSPunctSpecial = { fg = colors.red }, -- Special punctuation
            TSRepeat = { fg = colors.red, style = cfg.code_style.keywords }, -- Repeat statements
            TSString = { fg = colors.green, style = cfg.code_style.strings }, -- String literals
            TSStringRegex = { fg = colors.orange, style = cfg.code_style.strings }, -- Regex strings
            TSStringEscape = { fg = colors.red, style = cfg.code_style.strings }, -- Escape sequences in strings
            TSSymbol = { fg = colors.cyan }, -- Symbols
            TSTag = { fg = colors.purple }, -- Tags
            TSTagDelimiter = { fg = colors.purple }, -- Tag delimiters
            TSText = { fg = colors.fg }, -- Plain text
            TSStrong = { fg = colors.fg, style = "bold" }, -- Strong text
            TSEmphasis = { fg = colors.fg, style = "italic" }, -- Emphasized text
            TSUnderline = { fg = colors.fg, style = "underline" }, -- Underlined text
            TSStrike = { fg = colors.fg, style = "strikethrough" }, -- Strikethrough text
            TSTitle = { fg = colors.orange, style = "bold" }, -- Text titles
            TSLiteral = { fg = colors.green }, -- Literal text
            TSURI = { fg = colors.cyan, style = "underline" }, -- URI text
            TSMath = { fg = colors.fg }, -- Math text
            TSTextReference = { fg = colors.blue }, -- Reference text
            TSEnvironment = { fg = colors.fg }, -- Text environment
            TSEnvironmentName = { fg = colors.fg }, -- Text environment name
            TSNote = { fg = colors.fg }, -- Notes
            TSWarning = { fg = colors.fg }, -- Warnings
            TSDanger = { fg = colors.fg }, -- Dangers
            TSType = { fg = colors.purple }, -- Type names
            TSTypeBuiltin = { fg = colors.blue }, -- Built-in type names
            TSVariable = { fg = colors.fg, style = cfg.code_style.variables }, -- Variable names
            TSVariableBuiltin = { fg = colors.red, style = cfg.code_style.variables }, -- Built-in variable names
        }        end
        -- Set up default diagnostics config if not provided
        if not cfg.diagnostics then
            cfg.diagnostics = {
                background = false,
                undercurl = true
            }
        end

        -- 🧪 LSP & Diagnostics: Highlights for Language Server Protocol (LSP) features and diagnostic messages.
        local diagnostics_error_color = colors.dark_red or colors.red
        local diagnostics_hint_color = colors.dark_purple or colors.purple
        local diagnostics_warn_color = colors.dark_yellow or colors.yellow
        local diagnostics_info_color = colors.dark_cyan or colors.cyan

        hl.plugins.lsp = {
            -- Specific LSP C++ highlights (often provided by clangd)
            LspCxxHlGroupEnumConstant = colors_helper.Orange,                                       -- C++ enum constants
            LspCxxHlGroupMemberVariable = colors_helper.Orange,                                     -- C++ member variables
            LspCxxHlGroupNamespace = colors_helper.Blue,                                            -- C++ namespace names
            LspCxxHlSkippedRegion = colors_helper.Grey,                                             -- Skipped regions in C++ (e.g., inactive preprocessor blocks)
            LspCxxHlSkippedRegionBeginEnd = colors_helper.Red,                                      -- Begin/end markers for skipped regions in C++

            DiagnosticError = { fg = colors.red },                                                  -- Foreground color for diagnostic errors
            DiagnosticHint = { fg = colors.purple },                                                -- Foreground color for diagnostic hints
            DiagnosticInfo = { fg = colors.cyan },                                                  -- Foreground color for diagnostic info
            DiagnosticWarn = { fg = colors.yellow },                                                -- Foreground color for diagnostic warnings

            -- Virtual text for diagnostics (inline messages)
            DiagnosticVirtualTextError = {
                bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, colors.bg) or "none",
                fg = diagnostics_error_color
            },
            DiagnosticVirtualTextWarn = {
                bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, colors.bg) or "none",
                fg = diagnostics_warn_color
            },
            DiagnosticVirtualTextInfo = {
                bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, colors.bg) or "none",
                fg = diagnostics_info_color
            },
            DiagnosticVirtualTextHint = {
                bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, colors.bg) or "none",
                fg = diagnostics_hint_color
            },

            -- Underline for diagnostics
            DiagnosticUnderlineError = { undercurl = cfg.diagnostics.undercurl, underline = not cfg.diagnostics.undercurl, sp = colors.red }, -- Underline for errors
            DiagnosticUnderlineHint = { undercurl = cfg.diagnostics.undercurl, underline = not cfg.diagnostics.undercurl, sp = colors.purple }, -- Underline for hints
            DiagnosticUnderlineInfo = { undercurl = cfg.diagnostics.undercurl, underline = not cfg.diagnostics.undercurl, sp = colors.blue }, -- Underline for info
            DiagnosticUnderlineWarn = { undercurl = cfg.diagnostics.undercurl, underline = not cfg.diagnostics.undercurl, sp = colors.yellow }, -- Underline for warnings
            LspReferenceText = { bg = colors.lighter_gray },                                        -- Background for text references (e.g., 'go to definition')
            LspReferenceWrite = { bg = colors.lighter_gray },                                       -- Background for write references
            LspReferenceRead = { bg = colors.lighter_gray },                                        -- Background for read references

            LspCodeLens = { fg = colors.gray, fmt = cfg.code_style.comments },                      -- CodeLens text
            LspCodeLensSeparator = { fg = colors.gray },                                            -- CodeLens separator
        }

        -- LSP semantic tokens (nvim-0.9+ specific)
        if vim.api.nvim_call_function("has", { "nvim-0.9" }) == 1 then
            hl.plugins.lsp["@lsp.type.comment"] = hl.treesitter["@comment"]                        -- LSP semantic token for comment
            hl.plugins.lsp["@lsp.type.enum"] = hl.treesitter["@type"]                              -- LSP semantic token for enum
            hl.plugins.lsp["@lsp.type.enumMember"] = hl.treesitter["@constant.builtin"]            -- LSP semantic token for enum member
            hl.plugins.lsp["@lsp.type.interface"] = hl.treesitter["@type"]                         -- LSP semantic token for interface
            hl.plugins.lsp["@lsp.type.typeParameter"] = hl.treesitter["@type"]                     -- LSP semantic token for type parameter
            hl.plugins.lsp["@lsp.type.keyword"] = hl.treesitter["@keyword"]                        -- LSP semantic token for keyword
            hl.plugins.lsp["@lsp.type.namespace"] = hl.treesitter["@module"]                       -- LSP semantic token for namespace
            hl.plugins.lsp["@lsp.type.parameter"] = hl.treesitter["@variable.parameter"]           -- LSP semantic token for parameter
            hl.plugins.lsp["@lsp.type.property"] = hl.treesitter["@property"]                      -- LSP semantic token for property
            hl.plugins.lsp["@lsp.type.variable"] = hl.treesitter["@variable"]                      -- LSP semantic token for variable
            hl.plugins.lsp["@lsp.type.macro"] = hl.treesitter["@function.macro"]                   -- LSP semantic token for macro
            hl.plugins.lsp["@lsp.type.method"] = hl.treesitter["@function.method"]                 -- LSP semantic token for method
            hl.plugins.lsp["@lsp.type.number"] = hl.treesitter["@number"]                          -- LSP semantic token for number
            hl.plugins.lsp["@lsp.type.generic"] = hl.treesitter["@text"]                           -- LSP semantic token for generic
            hl.plugins.lsp["@lsp.type.builtinType"] = hl.treesitter["@type.builtin"]               -- LSP semantic token for built-in type
            hl.plugins.lsp["@lsp.typemod.method.defaultLibrary"] = hl.treesitter["@function"]      -- LSP type modifier for default library method
            hl.plugins.lsp["@lsp.typemod.function.defaultLibrary"] = hl.treesitter["@function"]    -- LSP type modifier for default library function
            hl.plugins.lsp["@lsp.typemod.operator.injected"] = hl.treesitter["@operator"]          -- LSP type modifier for injected operator
            hl.plugins.lsp["@lsp.typemod.string.injected"] = hl.treesitter["@string"]              -- LSP type modifier for injected string
            hl.plugins.lsp["@lsp.typemod.variable.defaultLibrary"] = hl.treesitter["@variable.builtin"] -- LSP type modifier for default library variable
            hl.plugins.lsp["@lsp.typemod.variable.injected"] = hl.treesitter["@variable"]          -- LSP type modifier for injected variable
            hl.plugins.lsp["@lsp.typemod.variable.static"] = hl.treesitter["@constant"]            -- LSP type modifier for static variable
            
            -- Need to find out if these fits the above or are different.
            --['@lsp.type.namespace'] = { link = '@module' },
            --['@lsp.type.type'] = { link = '@type' },
            --['@lsp.type.class'] = { link = '@type' },
            --['@lsp.type.enum'] = { link = '@type' },
            --['@lsp.type.interface'] = { link = '@type' },
            --['@lsp.type.struct'] = { link = '@variable.member' },
            --['@lsp.type.parameter'] = { fg = colors.purple },
            --['@lsp.type.field'] = { link = '@variable.member' },
            --['@lsp.type.variable'] = { link = '@variable' },
            --['@lsp.type.property'] = { link = '@property' },
            --['@lsp.type.enumMember'] = { link = '@constant' },
            --['@lsp.type.function'] = { link = '@function' },
            --['@lsp.type.method'] = { link = '@function.method' },
            --['@lsp.type.macro'] = { link = '@function.macro' },
            --['@lsp.type.decorator'] = { link = '@function' },
            --['@lsp.mod.constant'] = { link = '@constant' },

        end

        -- Aliases for LSP diagnostics (for compatibility)
        hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError                 -- Alias for default error diagnostic
        hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint                   -- Alias for default hint diagnostic
        hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo            -- Alias for default info diagnostic
        hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn                -- Alias for default warning diagnostic
        hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError      -- Alias for error underline diagnostic
        hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint        -- Alias for hint underline diagnostic
        hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo -- Alias for info underline diagnostic
        hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn     -- Alias for warning underline diagnostic
        hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError  -- Alias for error virtual text diagnostic
        hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn -- Alias for warning virtual text diagnostic
        hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo -- Alias for info virtual text diagnostic
        hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint    -- Alias for hint virtual text diagnostic

        -- 🔌 Plugin-specific Highlights: Custom highlights for various popular Neovim plugins.
        hl.plugins.ale = {
            ALEErrorSign = hl.plugins.lsp.DiagnosticError,                                          -- Sign for ALE errors
            ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,                                            -- Sign for ALE info messages
            ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,                                         -- Sign for ALE warnings
        }

        hl.plugins.barbar = {
            BufferCurrent = { bold = true },                                                        -- Current buffer in Barbar tabline
            BufferCurrentMod = { fg = colors.orange, bold = true, italic = true },                  -- Modified current buffer in Barbar tabline
            BufferCurrentSign = { fg = colors.purple },                                             -- Sign for current buffer
            BufferInactiveMod = { fg = colors.light_grey, bg = colors.menu, italic = true },        -- Modified inactive buffer in Barbar tabline
            BufferVisible = { fg = colors.light_grey, bg = colors.bg },                             -- Visible buffer in Barbar tabline
            BufferVisibleMod = { fg = colors.yellow, bg = colors.bg, italic = true },               -- Modified visible buffer in Barbar tabline
            BufferVisibleIndex = { fg = colors.light_grey, bg = colors.bg },                        -- Index of visible buffer
            BufferVisibleSign = { fg = colors.light_grey, bg = colors.bg },                         -- Sign for visible buffer
            BufferVisibleTarget = { fg = colors.light_grey, bg = colors.bg },                       -- Target for visible buffer
        }

        hl.plugins.cmp = {
            CmpItemAbbr = colors_helper.Fg,                                                         -- Abbreviation in nvim-cmp completion menu
            CmpItemAbbrDeprecated = { fg = colors.light_grey, strikethrough = true },               -- Deprecated abbreviation in nvim-cmp
            CmpItemAbbrMatch = colors_helper.Cyan,                                                  -- Matching abbreviation in nvim-cmp
            CmpItemAbbrMatchFuzzy = { fg = colors.cyan, underline = true },                         -- Fuzzy matching abbreviation in nvim-cmp
            CmpItemMenu = colors_helper.LightGrey,                                                  -- Menu text in nvim-cmp
            CmpItemKind = { fg = colors.purple, reverse = cfg.cmp_itemkind_reverse },               -- Kind icon in nvim-cmp
        }

        hl.plugins.blink = { -- Assuming 'blink' refers to blink.nvim or similar
            BlinkCmpLabel = colors_helper.Fg,                                                       -- Label in Blink completion
            BlinkCmpLabelDeprecated = { fg = colors.light_grey, strikethrough = true },             -- Deprecated label in Blink
            BlinkCmpLabelMatch = colors_helper.Cyan,                                                -- Matching label in Blink
            BlinkCmpDetail = colors_helper.LightGrey,                                               -- Detail text in Blink
            BlinkCmpKind = { fg = colors.purple },                                                  -- Kind icon in Blink
        }

        hl.plugins.coc = {
            CocErrorSign = hl.plugins.lsp.DiagnosticError,                                          -- Sign for CoC errors
            CocHintSign = hl.plugins.lsp.DiagnosticHint,                                            -- Sign for CoC hints
            CocInfoSign = hl.plugins.lsp.DiagnosticInfo,                                            -- Sign for CoC info messages
            CocWarningSign = hl.plugins.lsp.DiagnosticWarn,                                         -- Sign for CoC warnings
        }

        hl.plugins.whichkey = {
            WhichKey = colors_helper.Red,                                                           -- WhichKey prefix
            WhichKeyDesc = colors_helper.Blue,                                                      -- WhichKey description
            WhichKeyGroup = colors_helper.Orange,                                                   -- WhichKey group
            WhichKeySeparator = colors_helper.Green                                                 -- WhichKey separator
        }

        hl.plugins.gitgutter = {
            GitGutterAdd = colors_helper.Green,                                                     -- GitGutter sign for added lines
            GitGutterChange = colors_helper.Blue,                                                   -- GitGutter sign for changed lines
            GitGutterDelete = colors_helper.Red,                                                    -- GitGutter sign for deleted lines
        }

        hl.plugins.hop = {
            HopNextKey = { fg = colors.red, bold = true },                                          -- First Hop key
            HopNextKey1 = { fg = colors.cyan, bold = true },                                        -- Second Hop key
            HopNextKey2 = { fg = util.darken(colors.blue, 0.7, colors.bg) },                        -- Third Hop key (darkened blue)
            HopUnmatched = colors_helper.Grey,                                                      -- Unmatched Hop key
        }

        hl.plugins.diffview = {
            DiffviewFilePanelTitle = { fg = colors.blue, bold = true },                             -- Title in Diffview file panel
            DiffviewFilePanelCounter = { fg = colors.purple, bold = true },                         -- Counter in Diffview file panel
            DiffviewFilePanelFileName = colors_helper.Fg,                                           -- File name in Diffview file panel
            DiffviewNormal = hl.common.Normal,                                                      -- Normal text in Diffview
            DiffviewCursorLine = hl.common.CursorLine,                                              -- Cursor line in Diffview
            DiffviewVertSplit = hl.common.VertSplit,                                                -- Vertical split in Diffview
            DiffviewSignColumn = hl.common.SignColumn,                                              -- Sign column in Diffview
            DiffviewStatusLine = hl.common.StatusLine,                                              -- Status line in Diffview
            DiffviewStatusLineNC = hl.common.StatusLineNC,                                          -- Inactive status line in Diffview
            DiffviewEndOfBuffer = hl.common.EndOfBuffer,                                            -- End of buffer in Diffview
            DiffviewFilePanelRootPath = colors_helper.Grey,                                         -- Root path in Diffview file panel
            DiffviewFilePanelPath = colors_helper.Grey,                                             -- File path in Diffview file panel
            DiffviewFilePanelInsertions = colors_helper.Green,                                      -- Insertions count in Diffview file panel
            DiffviewFilePanelDeletions = colors_helper.Red,                                         -- Deletions count in Diffview file panel
            DiffviewStatusAdded = colors_helper.Green,                                              -- Added status in Diffview
            DiffviewStatusUntracked = colors_helper.Blue,                                           -- Untracked status in Diffview
            DiffviewStatusModified = colors_helper.Blue,                                            -- Modified status in Diffview
            DiffviewStatusRenamed = colors_helper.Blue,                                             -- Renamed status in Diffview
            DiffviewStatusCopied = colors_helper.Blue,                                              -- Copied status in Diffview
            DiffviewStatusTypeChange = colors_helper.Blue,                                          -- Type change status in Diffview
            DiffviewStatusUnmerged = colors_helper.Blue,                                            -- Unmerged status in Diffview
            DiffviewStatusUnknown = colors_helper.Red,                                              -- Unknown status in Diffview
            DiffviewStatusDeleted = colors_helper.Red,                                              -- Deleted status in Diffview
            DiffviewStatusBroken = colors_helper.Red                                                -- Broken status in Diffview
        }

        hl.plugins.gitsigns = {
            GitSignsAdd = colors_helper.Green,                                                      -- GitSigns for added lines
            GitSignsAddLn = colors_helper.Green,                                                    -- GitSigns for added lines (line number)
            GitSignsAddNr = colors_helper.Green,                                                    -- GitSigns for added lines (number)
            GitSignsChange = colors_helper.Blue,                                                    -- GitSigns for changed lines
            GitSignsChangeLn = colors_helper.Blue,                                                  -- GitSigns for changed lines (line number)
            GitSignsChangeNr = colors_helper.Blue,                                                  -- GitSigns for changed lines (number)
            GitSignsDelete = colors_helper.Red,                                                     -- GitSigns for deleted lines
            GitSignsDeleteLn = colors_helper.Red,                                                   -- GitSigns for deleted lines (line number)
            GitSignsDeleteNr = colors_helper.Red                                                    -- GitSigns for deleted lines (number)
        }

        hl.plugins.neo_tree = {
            NeoTreeNormal = { fg = colors.fg, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- Normal background for Neo-tree
            NeoTreeNormalNC = { fg = colors.fg, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- Inactive background for Neo-tree
            NeoTreeVertSplit = { fg = colors.menu, bg = cfg.transparent and "none" or colors.menu }, -- Vertical split in Neo-tree
            NeoTreeWinSeparator = { fg = colors.menu, bg = cfg.transparent and "none" or colors.menu }, -- Window separator in Neo-tree
            NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and colors.menu or colors.bg_darker_sidebar, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- End of buffer in Neo-tree
            NeoTreeRootName = { fg = colors.orange, bold = true },                                  -- Root folder name in Neo-tree
            NeoTreeGitAdded = colors_helper.Green,                                                  -- Git added status in Neo-tree
            NeoTreeGitDeleted = colors_helper.Red,                                                  -- Git deleted status in Neo-tree
            NeoTreeGitModified = colors_helper.Yellow,                                              -- Git modified status in Neo-tree
            NeoTreeGitConflict = { fg = colors.red, bold = true, italic = true },                   -- Git conflict status in Neo-tree
            NeoTreeGitUntracked = { fg = colors.red, italic = true },                               -- Git untracked status in Neo-tree
            NeoTreeIndentMarker = colors_helper.Grey,                                               -- Indent markers in Neo-tree
            NeoTreeSymbolicLinkTarget = colors_helper.Purple,                                       -- Symbolic link target in Neo-tree
        }

        hl.plugins.neotest = {
            NeotestAdapterName = { fg = colors.purple, bold = true },                               -- Neotest adapter name
            NeotestDir = colors_helper.Cyan,                                                        -- Neotest directory
            NeotestExpandMarker = colors_helper.Grey,                                               -- Neotest expand marker
            NeotestFailed = colors_helper.Red,                                                      -- Neotest failed test
            NeotestFile = colors_helper.Cyan,                                                       -- Neotest file
            NeotestFocused = { bold = true, italic = true },                                        -- Neotest focused test
            NeotestIndent = colors_helper.Grey,                                                     -- Neotest indent guides
            NeotestMarked = { fg = colors.orange, bold = true },                                    -- Neotest marked test
            NeotestNamespace = colors_helper.Blue,                                                  -- Neotest namespace
            NeotestPassed = colors_helper.Green,                                                    -- Neotest passed test
            NeotestRunning = colors_helper.Yellow,                                                  -- Neotest running test
            NeotestWinSelect = { fg = colors.cyan, bold = true },                                   -- Neotest window selection
            NeotestSkipped = colors_helper.LightGrey,                                               -- Neotest skipped test
            NeotestTarget = colors_helper.Purple,                                                   -- Neotest target
            NeotestTest = colors_helper.Fg,                                                         -- Neotest test name
            NeotestUnknown = colors_helper.LightGrey,                                               -- Neotest unknown status
        }

        hl.plugins.nvim_tree = {
            NvimTreeNormal = { fg = colors.fg, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- Normal background for Nvim-tree
            NvimTreeNormalFloat = { fg = colors.fg, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- Normal float background for Nvim-tree
            NvimTreeVertSplit = { fg = colors.bg_darker_sidebar, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- Vertical split in Nvim-tree
            NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and colors.menu or colors.bg_darker_sidebar, bg = cfg.transparent and "none" or colors.bg_darker_sidebar }, -- End of buffer in Nvim-tree
            NvimTreeRootFolder = { fg = colors.orange, bold = true },                               -- Root folder in Nvim-tree
            NvimTreeGitDirty = colors_helper.Yellow,                                                -- Git dirty status in Nvim-tree
            NvimTreeGitNew = colors_helper.Green,                                                   -- Git new status in Nvim-tree
            NvimTreeGitDeleted = colors_helper.Red,                                                 -- Git deleted status in Nvim-tree
            NvimTreeSpecialFile = { fg = colors.yellow, underline = true },                         -- Special file in Nvim-tree
            NvimTreeIndentMarker = colors_helper.Fg,                                                -- Indent markers in Nvim-tree
            NvimTreeImageFile = { fg = colors.dark_purple },                                        -- Image file in Nvim-tree
            NvimTreeSymlink = colors_helper.Purple,                                                 -- Symbolic link in Nvim-tree
            NvimTreeFolderName = colors_helper.Blue,                                                -- Folder name in Nvim-tree
        }

        hl.plugins.telescope = {
            TelescopeBorder = colors_helper.Red,                                                    -- Border of Telescope window
            TelescopePromptBorder = colors_helper.Cyan,                                             -- Border of Telescope prompt
            TelescopeResultsBorder = colors_helper.Cyan,                                            -- Border of Telescope results
            TelescopePreviewBorder = colors_helper.Cyan,                                            -- Border of Telescope preview
            TelescopeMatching = { fg = colors.orange, bold = true },                                -- Matching text in Telescope
            TelescopePromptPrefix = colors_helper.Green,                                            -- Prompt prefix in Telescope
            TelescopeSelection = { bg = colors.lighter_gray },                                      -- Selected item in Telescope
            TelescopeSelectionCaret = colors_helper.Yellow                                          -- Caret for selected item in Telescope
        }

        hl.plugins.snacks = { -- Assuming 'snacks' is a custom dashboard/picker
            -- Dashboard
            SnacksDashboardHeader = colors_helper.Yellow,                                           -- Header in Snacks dashboard
            SnacksDashboardFooter = { fg = colors.dark_red, italic = true },                        -- Footer in Snacks dashboard
            SnacksDashboardSpecial = { fg = colors.dark_red, bold = true },                         -- Special text in Snacks dashboard
            SnacksDashboardDesc = colors_helper.Cyan,                                               -- Description in Snacks dashboard
            SnacksDashboardIcon = colors_helper.Cyan,                                               -- Icon in Snacks dashboard
            SnacksDashboardKey = colors_helper.Blue,                                                -- Key in Snacks dashboard

            -- Picker
            SnacksPicker = hl.common.Normal,                                                        -- Normal text in Snacks picker
            SnacksPickerBorder = colors_helper.Cyan,                                                -- Border of Snacks picker
            SnacksPickerTitle = colors_helper.Red,                                                  -- Title of Snacks picker
            SnacksPickerMatch = { fg = colors.orange, bold = true },                                -- Matching text in Snacks picker
        }

        hl.plugins.dashboard = {
            DashboardShortCut = colors_helper.Blue,                                                 -- Shortcut text in dashboard
            DashboardHeader = colors_helper.Yellow,                                                 -- Header in dashboard
            DashboardCenter = colors_helper.Cyan,                                                   -- Center text in dashboard
            DashboardFooter = { fg = colors.dark_red, italic = true }                               -- Footer in dashboard
        }

        hl.plugins.outline = { -- Assuming 'outline' refers to aerial.nvim or similar
            FocusedSymbol = { fg = colors.purple, bg = colors.lighter_gray, bold = true },          -- Focused symbol in outline
            AerialLine = { fg = colors.purple, bg = colors.lighter_gray, bold = true },             -- Line in Aerial outline
        }

        hl.plugins.navic = {
            NavicText = colors_helper.Fg,                                                           -- Text in Navic breadcrumbs
            NavicSeparator = colors_helper.LightGrey,                                               -- Separator in Navic breadcrumbs
        }

        hl.plugins.ts_rainbow = {
            rainbowcol1 = colors_helper.LightGrey,                                                  -- Rainbow parenthesis color 1
            rainbowcol2 = colors_helper.Yellow,                                                     -- Rainbow parenthesis color 2
            rainbowcol3 = colors_helper.Blue,                                                       -- Rainbow parenthesis color 3
            rainbowcol4 = colors_helper.Orange,                                                     -- Rainbow parenthesis color 4
            rainbowcol5 = colors_helper.Purple,                                                     -- Rainbow parenthesis color 5
            rainbowcol6 = colors_helper.Green,                                                      -- Rainbow parenthesis color 6
            rainbowcol7 = colors_helper.Red                                                         -- Rainbow parenthesis color 7
        }

        hl.plugins.ts_rainbow2 = {
            TSRainbowRed = colors_helper.Red,                                                       -- Tree-sitter Rainbow red
            TSRainbowYellow = colors_helper.Yellow,                                                 -- Tree-sitter Rainbow yellow
            TSRainbowBlue = colors_helper.Blue,                                                     -- Tree-sitter Rainbow blue
            TSRainbowOrange = colors_helper.Orange,                                                 -- Tree-sitter Rainbow orange
            TSRainbowGreen = colors_helper.Green,                                                   -- Tree-sitter Rainbow green
            TSRainbowViolet = colors_helper.Purple,                                                 -- Tree-sitter Rainbow violet
            TSRainbowCyan = colors_helper.Cyan,                                                     -- Tree-sitter Rainbow cyan
        }

        hl.plugins.rainbow_delimiters = {
            RainbowDelimiterRed = colors_helper.Red,                                                -- Rainbow Delimiters red
            RainbowDelimiterYellow = colors_helper.Yellow,                                          -- Rainbow Delimiters yellow
            RainbowDelimiterBlue = colors_helper.Blue,                                              -- Rainbow Delimiters blue
            RainbowDelimiterOrange = colors_helper.Orange,                                          -- Rainbow Delimiters orange
            RainbowDelimiterGreen = colors_helper.Green,                                            -- Rainbow Delimiters green
            RainbowDelimiterViolet = colors_helper.Purple,                                          -- Rainbow Delimiters violet
            RainbowDelimiterCyan = colors_helper.Cyan,                                              -- Rainbow Delimiters cyan
        }

        hl.plugins.indent_blankline = {
            IndentBlanklineIndent1 = colors_helper.Blue,                                            -- Indent Blankline indent color 1
            IndentBlanklineIndent2 = colors_helper.Green,                                           -- Indent Blankline indent color 2
            IndentBlanklineIndent3 = colors_helper.Cyan,                                            -- Indent Blankline indent color 3
            IndentBlanklineIndent4 = colors_helper.LightGrey,                                       -- Indent Blankline indent color 4
            IndentBlanklineIndent5 = colors_helper.Purple,                                          -- Indent Blankline indent color 5
            IndentBlanklineIndent6 = colors_helper.Red,                                             -- Indent Blankline indent color 6
            IndentBlanklineChar = { fg = colors.menu, nocombine = true },                           -- Indent Blankline character
            IndentBlanklineContextChar = { fg = colors.gray, nocombine = true },                    -- Indent Blankline context character
            IndentBlanklineContextStart = { sp = colors.gray, underline = true },                   -- Indent Blankline context start
            IndentBlanklineContextSpaceChar = { nocombine = true },                                 -- Indent Blankline context space character

            -- Ibl v3 (newer versions of indent-blankline)
            IblIndent = { fg = colors.menu, nocombine = true },                                     -- Ibl v3 indent character
            IblWhitespace = { fg = colors.gray, nocombine = true },                                 -- Ibl v3 whitespace character
            IblScope = { fg = colors.gray, nocombine = true },                                      -- Ibl v3 scope character
        }

        hl.plugins.mini = { -- Mini.nvim plugin suite
            MiniAnimateCursor = { reverse = true, nocombine = true },                               -- Mini.nvim animate cursor
            MiniAnimateNormalFloat = hl.common.NormalFloat,                                         -- Mini.nvim animate normal float

            MiniClueBorder = hl.common.FloatBorder,                                                 -- Mini.nvim clue border
            MiniClueDescGroup = hl.plugins.lsp.DiagnosticWarn,                                      -- Mini.nvim clue description group
            MiniClueDescSingle = hl.common.NormalFloat,                                             -- Mini.nvim clue description single
            MiniClueNextKey = hl.plugins.lsp.DiagnosticHint,                                        -- Mini.nvim clue next key
            MiniClueNextKeyWithPostkeys = hl.plugins.lsp.DiagnosticError,                           -- Mini.nvim clue next key with postkeys
            MiniClueSeparator = hl.plugins.lsp.DiagnosticInfo,                                      -- Mini.nvim clue separator
            MiniClueTitle = colors_helper.Cyan,                                                     -- Mini.nvim clue title

            MiniCompletionActiveParameter = { underline = true },                                   -- Mini.nvim completion active parameter

            MiniCursorword = { underline = true },                                                  -- Mini.nvim cursor word
            MiniCursorwordCurrent = { underline = true },                                           -- Mini.nvim cursor word current

            MiniDepsChangeAdded = hl.common.Added,                                                  -- Mini.nvim deps change added
            MiniDepsChangeRemoved = hl.common.Removed,                                              -- Mini.nvim deps change removed
            MiniDepsHint = hl.plugins.lsp.DiagnosticHint,                                           -- Mini.nvim deps hint
            MiniDepsInfo = hl.plugins.lsp.DiagnosticInfo,                                           -- Mini.nvim deps info
            MiniDepsMsgBreaking = hl.plugins.lsp.DiagnosticWarn,                                    -- Mini.nvim deps message breaking
            MiniDepsPlaceholder = hl.syntax.Comment,                                                -- Mini.nvim deps placeholder
            MiniDepsTitle = hl.syntax.Title,                                                        -- Mini.nvim deps title
            MiniDepsTitleError = hl.common.DiffDelete,                                              -- Mini.nvim deps title error
            MiniDepsTitleSame = hl.common.DiffText,                                                 -- Mini.nvim deps title same
            MiniDepsTitleUpdate = hl.common.DiffAdd,                                                -- Mini.nvim deps title update

            MiniDiffSignAdd = colors_helper.Green,                                                  -- Mini.nvim diff sign add
            MiniDiffSignChange = colors_helper.Blue,                                                -- Mini.nvim diff sign change
            MiniDiffSignDelete = colors_helper.Red,                                                 -- Mini.nvim diff sign delete
            MiniDiffOverAdd = hl.common.DiffAdd,                                                    -- Mini.nvim diff over add
            MiniDiffOverChange = hl.common.DiffText,                                                -- Mini.nvim diff over change
            MiniDiffOverContext = hl.common.DiffChange,                                             -- Mini.nvim diff over context
            MiniDiffOverDelete = hl.common.DiffDelete,                                              -- Mini.nvim diff over delete

            MiniFilesBorder = hl.common.FloatBorder,                                                -- Mini.nvim files border
            MiniFilesBorderModified = hl.plugins.lsp.DiagnosticWarn,                                -- Mini.nvim files border modified
            MiniFilesCursorLine = { bg = colors.lighter_gray },                                     -- Mini.nvim files cursor line
            MiniFilesDirectory = hl.common.Directory,                                               -- Mini.nvim files directory
            MiniFilesFile = colors_helper.Fg,                                                       -- Mini.nvim files file
            MiniFilesNormal = hl.common.NormalFloat,                                                -- Mini.nvim files normal
            MiniFilesTitle = colors_helper.Cyan,                                                    -- Mini.nvim files title
            MiniFilesTitleFocused = { fg = colors.cyan, bold = true },                              -- Mini.nvim files title focused

            MiniHipatternsFixme = { fg = colors.black, bg = colors.red, bold = true },              -- Mini.nvim hipatterns fixme
            MiniHipatternsHack = { fg = colors.black, bg = colors.yellow, bold = true },            -- Mini.nvim hipatterns hack
            MiniHipatternsNote = { fg = colors.black, bg = colors.cyan, bold = true },              -- Mini.nvim hipatterns note
            MiniHipatternsTodo = { fg = colors.black, bg = colors.purple, bold = true },            -- Mini.nvim hipatterns todo

            MiniIconsAzure = colors_helper.Blue,                                                    -- Mini.nvim icons azure
            MiniIconsBlue = colors_helper.Blue,                                                     -- Mini.nvim icons blue
            MiniIconsCyan = colors_helper.Cyan,                                                     -- Mini.nvim icons cyan
            MiniIconsGreen = colors_helper.Green,                                                   -- Mini.nvim icons green
            MiniIconsGrey = colors_helper.Fg,                                                       -- Mini.nvim icons grey
            MiniIconsOrange = colors_helper.Orange,                                                 -- Mini.nvim icons orange
            MiniIconsPurple = colors_helper.Purple,                                                 -- Mini.nvim icons purple
            MiniIconsRed = colors_helper.Red,                                                       -- Mini.nvim icons red
            MiniIconsYellow = colors_helper.Yellow,                                                 -- Mini.nvim icons yellow

            MiniIndentscopeSymbol = colors_helper.Grey,                                             -- Mini.nvim indentscope symbol
            MiniIndentscopePrefix = { nocombine = true },                                           -- Mini.nvim indentscope prefix (invisible)

            MiniJump = { fg = colors.purple, underline = true, sp = colors.purple },                -- Mini.nvim jump

            MiniJump2dDim = colors_helper.Grey,                                                     -- Mini.nvim jump 2D dim
            MiniJump2dSpot = { fg = colors.red, bold = true, nocombine = true },                    -- Mini.nvim jump 2D spot
            MiniJump2dSpotAhead = { fg = colors.cyan, bg = colors.bg, nocombine = true },           -- Mini.nvim jump 2D spot ahead
            MiniJump2dSpotUnique = { fg = colors.yellow, bold = true, nocombine = true },           -- Mini.nvim jump 2D spot unique

            MiniMapNormal = hl.common.NormalFloat,                                                  -- Mini.nvim map normal
            MiniMapSymbolCount = hl.syntax.Special,                                                 -- Mini.nvim map symbol count
            MiniMapSymbolLine = hl.syntax.Title,                                                    -- Mini.nvim map symbol line
            MiniMapSymbolView = hl.syntax.Delimiter,                                                -- Mini.nvim map symbol view

            MiniNotifyBorder = hl.common.FloatBorder,                                               -- Mini.nvim notify border
            MiniNotifyNormal = hl.common.NormalFloat,                                               -- Mini.nvim notify normal
            MiniNotifyTitle = colors_helper.Cyan,                                                   -- Mini.nvim notify title

            MiniOperatorsExchangeFrom = hl.common.IncSearch,                                        -- Mini.nvim operators exchange from

            MiniPickBorder = hl.common.FloatBorder,                                                 -- Mini.nvim pick border
            MiniPickBorderBusy = hl.plugins.lsp.DiagnosticWarn,                                     -- Mini.nvim pick border busy
            MiniPickBorderText = { fg = colors.cyan, bold = true },                                 -- Mini.nvim pick border text
            MiniPickIconDirectory = hl.common.Directory,                                            -- Mini.nvim pick icon directory
            MiniPickIconFile = hl.common.NormalFloat,                                               -- Mini.nvim pick icon file
            MiniPickHeader = hl.plugins.lsp.DiagnosticHint,                                         -- Mini.nvim pick header
            MiniPickMatchCurrent = { bg = colors.lighter_gray },                                    -- Mini.nvim pick match current
            MiniPickMatchMarked = { bg = colors.diff_text },                                        -- Mini.nvim pick match marked
            MiniPickMatchRanges = hl.plugins.lsp.DiagnosticHint,                                    -- Mini.nvim pick match ranges
            MiniPickNormal = hl.common.NormalFloat,                                                 -- Mini.nvim pick normal
            MiniPickPreviewLine = { bg = colors.lighter_gray },                                     -- Mini.nvim pick preview line
            MiniPickPreviewRegion = hl.common.IncSearch,                                            -- Mini.nvim pick preview region
            MiniPickPrompt = hl.plugins.lsp.DiagnosticInfo,                                         -- Mini.nvim pick prompt

            MiniStarterCurrent = { nocombine = true },                                              -- Mini.nvim starter current
            MiniStarterFooter = { fg = colors.dark_red, italic = true },                            -- Mini.nvim starter footer
            MiniStarterHeader = colors_helper.Yellow,                                               -- Mini.nvim starter header
            MiniStarterInactive = { fg = colors.gray, fmt = cfg.code_style.comments },              -- Mini.nvim starter inactive
            MiniStarterItem = { fg = colors.fg, bg = cfg.transparent and "none" or colors.bg },     -- Mini.nvim starter item
            MiniStarterItemBullet = { fg = colors.gray },                                           -- Mini.nvim starter item bullet
            MiniStarterItemPrefix = { fg = colors.yellow },                                         -- Mini.nvim starter item prefix
        }

        -- Iterate and apply all highlights
        for _, group_table in pairs(hl) do
            vim_highlights(group_table)
        end
        -- Also apply plugin highlights
        for _, plugin_group_table in pairs(hl.plugins) do
            vim_highlights(plugin_group_table)
        end
    end
    return M
