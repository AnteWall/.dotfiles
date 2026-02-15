return {
	"folke/trouble.nvim",
	config = function()
		local trouble = require("trouble")
		trouble.setup({})

		vim.keymap.set("n", "<leader>tt", function()
			trouble.toggle("diagnostics")
		end, { desc = "Trouble: toggle diagnostics" })

		vim.keymap.set("n", "[t", function()
			trouble.prev({ skip_groups = true, jump = true })
		end, { desc = "Trouble: previous item" })

		vim.keymap.set("n", "]t", function()
			trouble.next({ skip_groups = true, jump = true })
		end, { desc = "Trouble: next item" })

		vim.keymap.set("n", "<leader>tp", function()
			trouble.prev({ skip_groups = true, jump = true })
		end, { desc = "Trouble: previous item" })

		vim.keymap.set("n", "<leader>tn", function()
			trouble.next({ skip_groups = true, jump = true })
		end, { desc = "Trouble: next item" })
	end,
}
