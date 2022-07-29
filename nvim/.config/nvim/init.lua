-- Bootstrap Packer
if require("first_load")() then
  return
end

-- load configs
require("keymaps")
require("plugins")
require("settings")
