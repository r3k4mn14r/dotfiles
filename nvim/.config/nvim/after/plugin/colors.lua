vim.opt.termguicolors = true
rawset(require("colorbuddy").styles, "italic", require("colorbuddy").styles.none)

require("colorbuddy").colorscheme "gruvbuddy"
require("colorizer").setup()

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("@variable", c.superwhite, nil)

Group.new("TSPunctBracket", c.orange:light():light())

Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

Group.new("pythonTSType", c.red)

Group.new("typescriptTSConstructor", g.pythonTSType)
Group.new("typescriptTSProperty", c.blue)

Group.new("WinSeparator", nil, nil)

Group.new("TSTitle", c.blue)

Group.new("InjectedLanguage", nil, g.Normal.bg:dark())

Group.new("LspParameter", nil, nil, s.italic)
Group.new("LspDeprecated", nil, nil, s.strikethrough)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

Group.new("VirtNonText", c.gray3:dark(), nil, s.italic)

Group.new("TreesitterContext", nil, g.Normal.bg:light())
Group.new("TreesitterContextLineNumber", c.blue)

Group.new("@property", c.blue)
Group.new("@punctuation.bracket.rapper", c.gray3, nil, s.none)
Group.new("@rapper_argument", c.red, nil, s.italic)
Group.new("@rapper_return", c.orange:light(), nil, s.italic)
