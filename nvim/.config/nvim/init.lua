-- Bootstrap Packer
if require("first_load")() then
  return
end

-- load configs
require("mappings")
require("plugins")
require("settings")
require("theme")

-- load plugin settings
require("plugin.lualine")
require("plugin.lsp")
require("plugin.treesitter")
require("plugin.telescope")
require("plugin.ironconfig")
