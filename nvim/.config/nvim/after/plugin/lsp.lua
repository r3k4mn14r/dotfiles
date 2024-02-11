-- lsp configurations

local on_attach = function(_, bufnr)
    local map = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('n', '<leader>vd', vim.diagnostic.open_float, '[V]iew [D]iagnotics')
    map('n', '<leader>vws', vim.lsp.buf.workspace_symbol, '[V]iew [W]orkspace [S]ymbols')
    map('n', '<leader>vr', vim.lsp.buf.references, '[V]iew [R]eferences')
    map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('n', '[d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
    map('n', ']d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
    map('i', '<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- remove in-line virtual-text diagnostics
    vim.diagnostic.config({ virtual_text = false, })
end

local servers = {
    rust_analyzer = {
        checkOnSave = {
          command = "clippy"
        },
        cargo = {
          allFeatures = true,
        },
    },
    pylsp = {
      pylsp = {
        plugins = {
          -- for nice interaction with black
          pycodestyle = {
            ignore = {'E203', 'W503', 'E704'},
            maxLineLength = 88
          },
        }
      }
    },
    tsserver = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        }),
	sources = {
		{name = "nvim_lsp"},
		{name = "luasnip"},
		{name = "buffer"},
	},
})
