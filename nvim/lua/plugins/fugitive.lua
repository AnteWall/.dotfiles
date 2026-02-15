return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })

		local klante_fugitive = vim.api.nvim_create_augroup("Klante_Fugitive", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = klante_fugitive,
			pattern = { "fugitive", "fugitiveblame" },
			callback = function(args)
				local opts = { buffer = args.buf, remap = false, silent = true }

				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, vim.tbl_extend("force", opts, { desc = "Git push" }))

				vim.keymap.set("n", "<leader>P", function()
					vim.cmd.Git({ "pull", "--rebase" })
				end, vim.tbl_extend("force", opts, { desc = "Git pull rebase" }))

				vim.keymap.set("n", "<leader>gp", function()
					vim.cmd.Git("push")
				end, vim.tbl_extend("force", opts, { desc = "Git push" }))

				vim.keymap.set("n", "<leader>gP", function()
					vim.cmd.Git({ "pull", "--rebase" })
				end, vim.tbl_extend("force", opts, { desc = "Git pull rebase" }))

				vim.keymap.set(
					"n",
					"<leader>t",
					":Git push -u origin ",
					vim.tbl_extend("force", opts, { desc = "Git push set upstream" })
				)

				vim.keymap.set(
					"n",
					"<leader>gt",
					":Git push -u origin ",
					vim.tbl_extend("force", opts, { desc = "Git push set upstream" })
				)
			end,
		})

		vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Git choose left" })
		vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Git choose right" })
	end,
}
