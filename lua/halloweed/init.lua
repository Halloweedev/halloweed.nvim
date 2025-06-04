local M = {}

-- Available styles (can be expanded)
M.styles_list = { "light" }

-- Default config
local default_config = {
    style = "light",
    toggle_style_key = nil,
    toggle_style_list = M.styles_list,
    toggle_style_index = 0,
    transparent = false,
    term_colors = true,
    colors = {},      -- user override
    highlights = {},  -- user override
    code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "none",
        strings = "none",
        variables = "none",
    },
}

-- Utility to update global config
function M.set_option(key, value)
    local cfg = vim.g.halloweed_config or {}
    cfg[key] = value
    vim.g.halloweed_config = cfg
end

-- Main setup function
---@param opts table|nil
function M.setup(opts)
    -- Initialize config if first time
    if not vim.g.halloweed_config or not vim.g.halloweed_config.loaded then
        vim.g.halloweed_config = vim.tbl_deep_extend("keep", vim.g.halloweed_config or {}, default_config)
        M.set_option("loaded", true)
    end

    -- Merge in new options
    if opts then
        vim.g.halloweed_config = vim.tbl_deep_extend("force", vim.g.halloweed_config, opts)
        if opts.toggle_style_list then
            M.set_option("toggle_style_list", opts.toggle_style_list)
        end
    end

    -- Set toggle key if defined
    if vim.g.halloweed_config.toggle_style_key then
        vim.api.nvim_set_keymap(
            "n",
            vim.g.halloweed_config.toggle_style_key,
            "<cmd>lua require('halloweed').toggle()<cr>",
            { noremap = true, silent = true }
        )
    end
end

-- Apply the colorscheme
function M.colorscheme()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end
    vim.o.termguicolors = true
    vim.g.colors_name = "halloweed"

    local cfg = vim.g.halloweed_config
    local ok, colors_mod = pcall(require, "halloweed.colors")
    if not ok then
        vim.notify("[halloweed] Missing 'colors.lua'", vim.log.levels.ERROR)
        return
    end

    local colors = colors_mod.setup(cfg.style) or colors_mod.setup("light")

    require("halloweed.highlights").setup(colors, cfg)

    if cfg.term_colors then
        require("halloweed.terminal").setup(colors)
    end
end

-- Toggle between styles
function M.toggle()
    local cfg = vim.g.halloweed_config
    local index = cfg.toggle_style_index + 1
    if index > #cfg.toggle_style_list then index = 1 end

    M.set_option("style", cfg.toggle_style_list[index])
    M.set_option("toggle_style_index", index)

    vim.cmd("colorscheme halloweed")
end

-- Reload helper (optional for dev use)
function M.reload()
    package.loaded["halloweed.colors"] = nil
    package.loaded["halloweed.highlights"] = nil
    package.loaded["halloweed.terminal"] = nil
    M.colorscheme()
end

-- Load hook (for plugin managers)
function M.load()
    vim.cmd("colorscheme halloweed")
end

return M
