return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({})

		wk.add({
			{ "<leader>a", desc = "Harpoon add file" },
			{ "<leader>c", group = "Code" },
			{ "<leader>ca", desc = "Code action" },
			{ "<leader>e", desc = "Line diagnostics" },
			{ "<leader>f", desc = "Format" },
			{ "<leader>g", group = "Git" },
			{ "<leader>gp", desc = "Git push" },
			{ "<leader>gP", desc = "Git pull rebase" },
			{ "<leader>gs", desc = "Git status" },
			{ "<leader>gt", desc = "Git push set upstream" },
			{ "<leader>p", group = "Paste/Push" },
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
