-- lsp configurations

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- setup nvim-cmp

local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end,
	},

	sources = {
		{name = "nvim_lsp"},
		{name = "luasnip"},
		{name = "buffer"},
	},
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
            -- See `:help vim.lsp.*` for documentation on any of the below functions
			nmap("gd", ":lua vim.lsp.buf.definition()<CR>")
			nmap("K", ":lua vim.lsp.buf.hover()<CR>")
			nmap("gi", ":lua vim.lsp.buf.implementation()<CR>")
			nmap("[d", ":lua vim.diagnostic.goto_next()<CR>")
			nmap("]d", ":lua vim.diagnostic.goto_prev()<CR>")
			nmap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
			nmap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
			nmap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
			nmap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
			nmap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
			imap("<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		end,
	}, _config or {})
end

-- setup language servers

require('lspconfig')['jedi_language_server'].setup(config({}))

require('lspconfig')['rust_analyzer'].setup(config({
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
}))

require('lspconfig')['tsserver'].setup(config({}))
