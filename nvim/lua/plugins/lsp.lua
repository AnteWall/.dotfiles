return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local function map(keys, fn, desc)
					vim.keymap.set("n", keys, fn, { buffer = args.buf, remap = false, silent = true, desc = desc })
				end

				map("gd", vim.lsp.buf.definition, "LSP goto definition")
				map("gD", vim.lsp.buf.declaration, "LSP goto declaration")
				map("gr", vim.lsp.buf.references, "LSP references")
				map("gi", vim.lsp.buf.implementation, "LSP goto implementation")
				map("K", vim.lsp.buf.hover, "LSP hover")
				map("<leader>rn", vim.lsp.buf.rename, "LSP rename")
				map("<leader>ca", vim.lsp.buf.code_action, "LSP code action")
				map("[d", vim.diagnostic.goto_prev, "Diagnostic previous")
				map("]d", vim.diagnostic.goto_next, "Diagnostic next")
				map("<leader>e", vim.diagnostic.open_float, "Line diagnostics")
				map("<S-Space>", vim.diagnostic.open_float, "Line diagnostics")
			end,
		})

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"vtsls",
				"pyright",
				"tailwindcss",
			},
				handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"heex",
						},
					})
				end,
				["vtsls"] = function()
					local lspconfig = require("lspconfig")
					local util = require("lspconfig.util")
					lspconfig.vtsls.setup({
						capabilities = capabilities,
						cmd = { vim.fn.stdpath("data") .. "/mason/bin/vtsls", "--stdio" },
						root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
						single_file_support = true,
						settings = {
							vtsls = {
								autoUseWorkspaceTsdk = true,
							},
							typescript = {
								tsdk = "node_modules/typescript/lib",
							},
							javascript = {
								tsdk = "node_modules/typescript/lib",
							},
						},
					})
				end,
					["pyright"] = function()
						local lspconfig = require("lspconfig")
						local util = require("lspconfig.util")
						local function find_python_path(start_path)
							local venv_dir = vim.fs.find(".venv", { path = start_path, upward = true, type = "directory" })[1]
							if venv_dir then
								local venv_python = venv_dir .. "/bin/python"
								if vim.fn.executable(venv_python) == 1 then
									return venv_python
								end
							end

							local python3 = vim.fn.exepath("python3")
							if python3 ~= "" then
								return python3
							end

							local python = vim.fn.exepath("python")
							if python ~= "" then
								return python
							end

							return "python3"
						end

						lspconfig.pyright.setup({
							capabilities = capabilities,
							cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
							root_dir = function(fname)
								return util.root_pattern(
									"pyproject.toml",
									"uv.lock",
									".venv",
									"setup.py",
									"setup.cfg",
									"requirements.txt"
								)(fname) or util.path.dirname(fname)
							end,
							on_new_config = function(new_config, root_dir)
								local python_path = find_python_path(root_dir)
								new_config.settings = vim.tbl_deep_extend("force", new_config.settings or {}, {
									python = {
										pythonPath = python_path,
										analysis = {
											autoSearchPaths = true,
											useLibraryCodeForTypes = true,
											diagnosticMode = "workspace",
										},
									},
								})
							end,
							single_file_support = true,
						})
					end,
				},
			})

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*.py",
			callback = function(args)
				local file_dir = vim.fn.fnamemodify(args.file, ":p:h")
				local venv = vim.fs.find(".venv", { path = file_dir, upward = true, type = "directory" })[1]
				if venv then
					require("uv").activate_venv(venv)
				end
			end,
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
