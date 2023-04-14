require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "rust", "lua" },
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
}
