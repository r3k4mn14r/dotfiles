local iron = require('iron.core')

iron.setup {
  config = {
    close_window_on_exit = true,
    repl_open_cmd = "botright vertical split",
    repl_definition = {
      python = {
        command = {"ipython"}
      }
    },
  },

  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
  }
}
