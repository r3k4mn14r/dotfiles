vim.opt.termguicolors = true

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

Group.new("LspParameter", nil, nil, s.none)
Group.new("LspDeprecated", nil, nil, s.strikethrough)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

Group.new("VirtNonText", c.gray3:dark(), nil, s.italic)

Group.new("TreesitterContext", nil, g.Normal.bg:light())
Group.new("TreesitterContextLineNumber", c.blue)

Group.new("@property", c.blue)
Group.new("constant", c.orange, nil, s.none)

vim.cmd [[highlight link @function.call.lua LuaFunctionCall]]
vim.cmd [[
  hi link @lsp.type.variable.lua variable
  hi link @lsp.type.variable.rust variable
  hi link @lsp.type.namespace @namespace
  hi link @punctuation.bracket.rapper @text.literal
  hi link @normal Normal
  hi link @tag.attribute.html type
  hi link @tag.delimiter.html @namespace
]]
