return {
	"sindrets/diffview.nvim",
	event = "BufRead",
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			use_icons = true,
		})
	end,
}
