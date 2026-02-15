-- Auto-generated Material 3 theme for NvChad
-- Generated from wallpaper: /home/user0o1/Pictures/wallpapers/kittycat.png
-- Mode: dark
-- Source color: #d2d1db

---@type Base46Table
local M = {}

-- UI Colors from Material 3
M.base_30 = {
  white = "#e5e2e2",
  black = "#141314",
  darker_black = "#141314",
  black2 = "#1c1b1c",
  one_bg = "#201f20",
  one_bg2 = "#2a2a2a",
  one_bg3 = "#353435",
  grey = "#46464b",
  grey_fg = "#c7c6cb",
  grey_fg2 = "#919095",
  light_grey = "#46464b",
  
  -- Accent colors
  red = "#ffb4ab",
  baby_pink = "#93000a",
  pink = "#ffeadf",
  line = "#919095",
  green = "#ffeadf",
  vibrant_green = "#e2cec3",
  nord_blue = "#c8c6ca",
  blue = "#efedf7",
  seablue = "#d2d1db",
  yellow = "#d6c3b8",
  sun = "#f3dfd3",
  purple = "#c8c6ca",
  dark_purple = "#47464a",
  teal = "#d2d1db",
  orange = "#ffeadf",
  cyan = "#c6c5cf",
  
  -- UI elements
  statusline_bg = "#201f20",
  lightbg = "#2a2a2a",
  pmenu_bg = "#efedf7",
  folder_bg = "#efedf7"
}

-- Syntax highlighting colors (base16 format)
M.base_16 = {
  base00 = "#141314",                    -- Default Background
  base01 = "#201f20",           -- Lighter Background
  base02 = "#2a2a2a",       -- Selection Background
  base03 = "#919095",                    -- Comments, Invisibles
  base04 = "#c7c6cb",           -- Dark Foreground
  base05 = "#e5e2e2",                  -- Default Foreground
  base06 = "#e5e2e2",                  -- Light Foreground
  base07 = "#3a3939",              -- Light Background
  base08 = "#ffb4ab",                      -- Variables, Tags
  base09 = "#ffeadf",                   -- Integers, Constants
  base0A = "#efedf7",                    -- Classes, Search
  base0B = "#ffeadf",                   -- Strings
  base0C = "#d2d1db",           -- Regex, Escapes
  base0D = "#efedf7",                    -- Functions, Methods
  base0E = "#c8c6ca",                  -- Keywords, Storage
  base0F = "#93000a"              -- Deprecated
}

-- Optional: Custom highlights
M.polish_hl = {
  defaults = {
    Comment = {
      fg = "#919095",
      italic = true,
    },
    LineNr = {
      fg = "#46464b",
    },
    CursorLine = {
      bg = "#1c1b1c",
    },
    CursorLineNr = {
      fg = "#efedf7",
      bold = true,
    },
    Visual = {
      bg = "#d2d1db",
    },
    Pmenu = {
      bg = "#201f20",
    },
    PmenuSel = {
      bg = "#d2d1db",
      fg = "#595962",
    },
    StatusLine = {
      bg = "#201f20",
      fg = "#e5e2e2",
    },
    TabLine = {
      bg = "#1c1b1c",
      fg = "#c7c6cb",
    },
    TabLineSel = {
      bg = "#d2d1db",
      fg = "#595962",
    },
    NvimTreeNormal = {
      bg = "#1c1b1c",
    },
    NvimTreeFolderIcon = {
      fg = "#efedf7",
    },
  },
  
  treesitter = {
    ["@keyword"] = { fg = "#c8c6ca" },
    ["@function"] = { fg = "#efedf7" },
    ["@function.builtin"] = { fg = "#d2d1db" },
    ["@variable"] = { fg = "#e5e2e2" },
    ["@variable.builtin"] = { fg = "#ffeadf" },
    ["@string"] = { fg = "#ffeadf" },
    ["@number"] = { fg = "#ffeadf" },
    ["@boolean"] = { fg = "#ffeadf" },
    ["@constant"] = { fg = "#ffeadf" },
    ["@type"] = { fg = "#c8c6ca" },
    ["@parameter"] = { fg = "#e5e2e2" },
    ["@property"] = { fg = "#e5e2e2" },
    ["@operator"] = { fg = "#c7c6cb" },
    ["@punctuation"] = { fg = "#46464b" },
    ["@comment"] = { 
      fg = "#919095", 
      italic = true 
    },
    ["@tag"] = { fg = "#ffb4ab" },
    ["@tag.attribute"] = { fg = "#ffeadf" },
    ["@tag.delimiter"] = { fg = "#46464b" },
  },

  lsp = {
    DiagnosticError = { fg = "#ffb4ab" },
    DiagnosticWarn = { fg = "#ffeadf" },
    DiagnosticInfo = { fg = "#efedf7" },
    DiagnosticHint = { fg = "#c8c6ca" },
    DiagnosticUnderlineError = { 
      undercurl = true, 
      sp = "#ffb4ab" 
    },
    DiagnosticUnderlineWarn = { 
      undercurl = true, 
      sp = "#ffeadf" 
    },
    DiagnosticUnderlineInfo = { 
      undercurl = true, 
      sp = "#efedf7" 
    },
    DiagnosticUnderlineHint = { 
      undercurl = true, 
      sp = "#c8c6ca" 
    },
  },

  telescope = {
    TelescopePromptBorder = { fg = "#efedf7" },
    TelescopeResultsBorder = { fg = "#919095" },
    TelescopePreviewBorder = { fg = "#919095" },
    TelescopeSelection = { 
      bg = "#d2d1db", 
      fg = "#595962" 
    },
    TelescopeMatching = { fg = "#efedf7", bold = true },
  },

  cmp = {
    CmpItemAbbrMatch = { fg = "#efedf7", bold = true },
    CmpItemAbbrMatchFuzzy = { fg = "#efedf7" },
    CmpItemKindVariable = { fg = "#e5e2e2" },
    CmpItemKindFunction = { fg = "#efedf7" },
    CmpItemKindKeyword = { fg = "#c8c6ca" },
    CmpItemKindConstant = { fg = "#ffeadf" },
    CmpItemKindModule = { fg = "#c8c6ca" },
  },

  git = {
    DiffAdd = { fg = "#ffeadf" },
    DiffChange = { fg = "#efedf7" },
    DiffDelete = { fg = "#ffb4ab" },
    GitSignsAdd = { fg = "#ffeadf" },
    GitSignsChange = { fg = "#efedf7" },
    GitSignsDelete = { fg = "#ffb4ab" },
  },
}

-- Set theme type based on wallpaper analysis
M.type = "dark"

-- Override theme
M = require("base46").override_theme(M, "material3")

return M
