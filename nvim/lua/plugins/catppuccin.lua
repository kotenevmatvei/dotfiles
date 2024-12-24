return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		transparent_background = true,
	},
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
