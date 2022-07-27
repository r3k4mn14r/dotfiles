local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.opt.completeopt = {"menu", "menuone", "noselect"}

local cmp = require'cmp'
cmp.setup({
snippet = {
   expand = function(args)
     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
   end,
},
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- setup language servers

require('lspconfig')['jedi_language_server'].setup{}

require('lspconfig')['rust_analyzer'].setup {
  server = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
        cargo = {
          allFeatures = true,
        },
        completion = {
          postfix = {
            enable = false,
          },
        },
      },
    },
  },
}
