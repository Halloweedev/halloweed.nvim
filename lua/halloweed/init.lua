local M = {}

-- Define available styles (you can expand this later)
M.styles_list = { "light" }  -- Add 'dark', etc. as you create them

-- Default config
local default_config = {
  style = "light",
  toggle_style_key = nil,
  toggle_style_list = M.styles_list,
  term_colors = true,
  transparent = false,
  colors = {},      -- user override
  highlights = {},  -- user override
}

-- Setup global config table
function M.set_option(opt, value)
  local cfg = vim.g.halloweed_config or {}
  cfg[opt] = value
  vim.g.halloweed_config = cfg
end

---@param opts table|nil
function M.setup(opts)
  if not vim.g.halloweed_config or not vim.g.halloweed_config.loaded then
    vim.g.halloweed_config = vim.tbl_deep_extend("keep", vim.g.halloweed_config or {}, default_config)
    M.set_option("loaded", true)
    M.set_option("toggle_style_index", 0)
  end

  if opts then
    vim.g.halloweed_config = vim.tbl_deep_extend("force", vim.g.halloweed_config, opts)
    if opts.toggle_style_list then
      M.set_option("toggle_style_list", opts.toggle_style_list)
    end
  end

  if vim.g.halloweed_config.toggle_style_key then
    vim.api.nvim_set_keymap("n", vim.g.halloweed_config.toggle_style_key, "<cmd>lua require('halloweed').toggle()<cr>", { noremap = true, silent = true })
  end
end

-- Apply colorscheme (same as `:colorscheme halloweed`)
function M.colorscheme()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.termguicolors = true
  vim.g.colors_name = "halloweed"

  local cfg = vim.g.halloweed_config
  local colors = require("halloweed.colors").setup(cfg.style)

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

-- Helper to load the theme (used in plugin manager)
function M.load()
  vim.cmd("colorscheme halloweed")
end

return M

