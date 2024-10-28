return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Setup Mason and related plugins
		mason.setup()
		mason_lspconfig.setup()

		-- LSP capabilities for autocompletion
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Define servers with specific configurations
		local servers = {
			clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			--tsserver = {}, -- for JavaScript and TypeScript
			html = { filetypes = { "html", "twig", "hbs" } },
			cssls = {},
			tailwindcss = {},
			dockerls = {},
			sqlls = {},
			terraformls = {},
			jsonls = {},
			yamlls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						diagnostics = { globals = { "vim" } },
					},
				},
			},
		}

		-- Configure each server
		mason_lspconfig.setup_handlers({
			function(server_name)
				local config = servers[server_name] or {}
				config.capabilities = capabilities
				lspconfig[server_name].setup(config)
			end,
		})

		-- Auto-install specified tools and LSP servers
		mason_tool_installer.setup({
			ensure_installed = {
				"clangd",
				"gopls",
				"pyright",
				"rust_analyzer",
				--"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"dockerls",
				"sqlls",
				"terraformls",
				"jsonls",
				"yamlls",
				"lua_ls",
				"stylua", -- Add all necessary tools
			},
			auto_update = false,
			run_on_start = true, -- Ensures tools are installed on Neovim startup
		})

		-- Set key mappings when LSP attaches to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_setup", { clear = true }),
			callback = function(event)
				local opts = { buffer = event.buf, desc = "LSP" }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		})
	end,
}
