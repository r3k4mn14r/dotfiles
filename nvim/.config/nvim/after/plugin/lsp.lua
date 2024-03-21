-- lsp configurations
local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
  return
end

local custom_attach = function(_, bufnr)
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
    map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('n', 'gT', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
    map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    map('n', '[d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
    map('n', ']d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
    map('i', '<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- remove in-line virtual-text diagnostics
    vim.diagnostic.config({ virtual_text = false, })
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

-- completion configuration
local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())

-- LSP server configurations
local servers = {
    rust_analyzer = {
        checkOnSave = {
          command = "clippy"
        },
        cargo = {
          allFeatures = true,
        },
    },
    pyright = true,
    html = true,
    yamlls = true,
    ruff_lsp = true,
    tsserver = {},
    lua_ls = {},
}

-- Setup mason so it can manage external tooling
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end
