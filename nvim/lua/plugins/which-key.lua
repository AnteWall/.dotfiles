return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({})

		vim.keymap.set("n", "<leader>g?", function()
			wk.show({ keys = "<leader>g", mode = "n" })
		end, { desc = "Git keymaps" })

		wk.add({
			{ "<leader>a", desc = "Harpoon add file" },
			{ "<leader>c", group = "Code" },
			{ "<leader>ca", desc = "Code action" },
			{ "<leader>e", desc = "Line diagnostics" },
			{ "<leader>f", desc = "Format" },
			{ "<leader>g", group = "Git" },
			{ "<leader>g?", desc = "Git keymaps" },
			{ "<leader>ga", desc = "Git add (prompt)" },
			{ "<leader>gA", desc = "Git add all" },
			{ "<leader>gc", desc = "Git commit" },
			{ "<leader>gC", desc = "Git commit message" },
			{ "<leader>gp", desc = "Git push" },
			{ "<leader>gP", desc = "Git pull rebase" },
			{ "<leader>gs", desc = "Git status" },
			{ "<leader>gt", desc = "Git push set upstream" },
			{ "<leader>p", group = "Paste" },
			{ "<leader>pv", desc = "Project tree" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>rn", desc = "Rename symbol" },
			{ "<leader>s", desc = "Substitute word" },
			{ "<leader>t", group = "Trouble" },
			{ "<leader>tn", desc = "Trouble next" },
			{ "<leader>tp", desc = "Trouble previous" },
			{ "<leader>tt", desc = "Trouble diagnostics" },
			{ "<leader>u", desc = "Undo tree" },
			{ "<leader>x", group = "UV" },
			{ "<leader>y", desc = "Yank to system" },
			{ "<leader>Y", desc = "Yank line to system" },
		})
	end,
}
