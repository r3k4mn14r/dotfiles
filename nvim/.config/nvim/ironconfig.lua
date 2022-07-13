local iron = require('iron.core')

iron.setup {
  config = {
    close_window_on_exit = true,
    python = require("iron.fts.python").ipython,
    -- should_map_plug = true,
    repl_open_cmd = "botright vertical split",
  },

  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
  }
}

