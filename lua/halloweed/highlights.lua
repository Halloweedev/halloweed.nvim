
local M = {}

function M.setup(colors)
    local highlights = {
        -- 🖥️ Editor + Window UI
        Normal        = { fg = colors.fg, bg = colors.bg },                -- Main text + background
        NormalNC      = { fg = colors.fg, bg = colors.bg },                -- Non-active window background
        Cursor        = { bg = colors.lighter_gray },                      -- Character under the cursor
        CursorLine    = { bg = colors.lighter_gray },                      -- Line highlight under cursor
        CursorColumn  = { bg = colors.lighter_gray },                      -- Column highlight (with :set cursorcolumn)
        CursorLineNr  = { fg = colors.orange },                            -- Line number of current line
        LineNr        = { fg = colors.gray },                              -- Line numbers (non-current)
        VertSplit     = { fg = colors.gray },                              -- Vertical split lines
        Visual        = { bg = colors.gray },                              -- Selection in visual mode
        Search        = { fg = colors.black, bg = colors.yellow },         -- Search result highlights
        IncSearch     = { fg = colors.black, bg = colors.orange },         -- While typing search
        MatchParen    = { fg = colors.red, bg = colors.lighter_gray },     -- Matching parenthesis
        ColorColumn   = { bg = colors.lighter_gray },                      -- Column highlight (with :set colorcolumn=80)
        Folded        = { fg = colors.gray, bg = colors.menu },            -- Folded code lines
        FoldColumn    = { fg = colors.gray },                              -- Column for fold indicators
        SignColumn    = { bg = colors.bg },                                -- Where signs like diagnostics appear
        EndOfBuffer   = { fg = colors.menu },                              -- Tildes (~) after buffer end
        NonText       = { fg = colors.gray },                              -- Non-code text (e.g., whitespace markers)

        -- ⌨️ Statusline, Tabs, Menus
        StatusLine    = { fg = colors.fg, bg = colors.menu },              -- Active statusline
        StatusLineNC  = { fg = colors.gray, bg = colors.menu },            -- Inactive statusline
        TabLine       = { fg = colors.gray, bg = colors.menu },            -- Tabs
        TabLineSel    = { fg = colors.fg, bg = colors.lighter_gray },      -- Selected tab
        TabLineFill   = { bg = colors.menu },                              -- Filler for tab bar
        Title         = { fg = colors.purple, bold = true },               -- Help/document titles

        -- 🍱 Popup Menus
        Pmenu         = { fg = colors.fg, bg = colors.gray },              -- Completion menu
        PmenuSel      = { fg = colors.black, bg = colors.orange },         -- Selected item in menu
        PmenuSbar     = { bg = colors.menu },                              -- Scrollbar in menu
        PmenuThumb    = { bg = colors.orange },                            -- Scrollbar thumb

        -- ⚠️ Messages + Diagnostics
        Error         = { fg = colors.red },                               -- Errors
        WarningMsg    = { fg = colors.orange },                            -- Warnings
        ModeMsg       = { fg = colors.fg },                                -- Messages in cmdline
        MoreMsg       = { fg = colors.green },                             -- -- More -- prompt
        Question      = { fg = colors.yellow },                            -- :confirm questions

        -- 🧠 Syntax Highlighting
        Comment       = { fg = colors.darker_gray, italic = true },        -- Comments
        Constant      = { fg = colors.orange },                            -- Constants
        String        = { fg = colors.green },                             -- Strings
        Character     = { fg = colors.green },                             -- Characters
        Number        = { fg = colors.orange },                            -- Numbers
        Boolean       = { fg = colors.orange },                            -- true, false
        Float         = { fg = colors.orange },                            -- Float numbers
        Identifier    = { fg = colors.cyan },                              -- Variable names
        Function      = { fg = colors.blue },                              -- Functions
        Statement     = { fg = colors.red },                               -- if, for, return
        Conditional   = { fg = colors.red },                               -- if, else
        Repeat        = { fg = colors.red },                               -- for, while
        Label         = { fg = colors.yellow },                            -- case, labels
        Operator      = { fg = colors.fg },                                -- +, -, *, etc
        Keyword       = { fg = colors.red },                               -- Keywords
        Exception     = { fg = colors.red },                               -- try, catch
        Type          = { fg = colors.purple },                            -- int, class, etc
        StorageClass  = { fg = colors.purple },                            -- static, extern
        Structure     = { fg = colors.purple },                            -- struct
        Typedef       = { fg = colors.purple },                            -- typedef
        Special       = { fg = colors.yellow },                            -- Escapes, special chars
        Underlined    = { underline = true },                              -- Markdown links, etc
        Todo          = { fg = colors.red, bg = colors.yellow },           -- TODO comments

        -- 🧪 LSP Diagnostics (if using LSP)
        DiagnosticError       = { fg = colors.red },                       -- LSP error
        DiagnosticWarn        = { fg = colors.orange },                    -- LSP warning
        DiagnosticInfo        = { fg = colors.blue },                      -- LSP info
        DiagnosticHint        = { fg = colors.cyan },                      -- LSP hint
        DiagnosticUnderlineError = { undercurl = true, sp = colors.red }, -- Error underline
        DiagnosticUnderlineWarn  = { undercurl = true, sp = colors.orange },
        DiagnosticUnderlineInfo  = { undercurl = true, sp = colors.blue },
        DiagnosticUnderlineHint  = { undercurl = true, sp = colors.cyan },

        -- Lazy.nvim UI
        LazyNormal         = { fg = colors.fg, bg = colors.bg },           -- Background of Lazy UI
        LazyH1             = { fg = colors.purple, bold = true },          -- Main section headers
        LazyH2             = { fg = colors.orange, bold = true },          -- Subsection headers
        LazyButton         = { fg = colors.fg, bg = colors.menu },         -- Normal buttons
        LazyButtonActive   = { fg = colors.black, bg = colors.orange },    -- Active/selected buttons
        LazyReasonCmd      = { fg = colors.blue },                         -- Reason: Cmd-based plugin
        LazyReasonEvent    = { fg = colors.green },                        -- Reason: Event-based plugin
        LazyReasonPlugin   = { fg = colors.cyan },                         -- Reason: Dependency plugin
        LazySpecial        = { fg = colors.yellow },                       -- Highlighted areas
        LazyProgressDone   = { fg = colors.green },                        -- Progress bar: completed
        LazyProgressTodo   = { fg = colors.gray },                         -- Progress bar: remaining
        LazyUrl            = { fg = colors.blue, underline = true },       -- URLs (clickable)

    }

    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
