-- Bootstrap Packer
if require("bootstrap_packer")() then
  return
end

-- load configs
require("keymaps")
require("plugins")
require("settings")
