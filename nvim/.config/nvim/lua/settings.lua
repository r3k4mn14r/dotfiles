local opt = vim.opt

opt.wildmode = {'longest', 'list', 'full'}
opt.pumblend = 17
opt.wildmode = opt.wildmode - 'list'
opt.wildmode = opt.wildmode + { 'longest', 'full' }
opt.wildoptions = 'pum'
opt.guicursor = ""
opt.showmode       = false
opt.showcmd        = true
opt.cmdheight      = 1
opt.incsearch      = true
opt.showmatch      = true
opt.relativenumber = true
opt.number         = true
opt.ignorecase     = true
opt.smartcase      = true
opt.cursorline     = true
opt.splitright     = true
opt.splitbelow     = true
opt.updatetime     = 1000
opt.hlsearch       = true
opt.scrolloff      = 8   
opt.autoindent     = true
opt.cindent        = true
opt.wrap           = true
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.expandtab      = true
opt.breakindent    = true
opt.showbreak      = string.rep(' ', 3)
opt.linebreak      = true
opt.foldmethod     = 'marker'
opt.foldlevel      = 0
opt.modelines      = 1
opt.belloff	   = 'all'
opt.writebackup	   = false
opt.backup	   = false
opt.swapfile	   = false
opt.formatoptions  = opt.formatoptions
                     - 'a'    -- Auto formatting is BAD.
                     - 't'    -- Don't auto format my code. I got linters for that.
                     + 'c'    -- In general, I like it when comments respect textwidth
                     + 'q'    -- Allow formatting comments w/ gq
                     - 'o'    -- O and o, don't continue comments
                     + 'r'    -- But do continue when pressing enter.
                     + 'n'    -- Indent past the formatlistpat, not underneath it.
                     + 'j'    -- Auto-remove comments if possible.
                     - '2'    -- I'm not in gradeschool anymore
