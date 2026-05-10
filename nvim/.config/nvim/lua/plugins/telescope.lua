return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			-- vim.keymap.set('n', '<C-p>', builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			-- vim.keymap.set("n", "<leader>ff", function()
			-- 	if vim.bo.filetype == "neo-tree" then
			-- 		-- If it is, jump to the previous window (your main editor)
			-- 		vim.cmd("wincmd p")
			-- 	end
			-- 	builtin.find_files({
			-- 		prompt_title = "Find Files",
			-- 		-- hidden = true, -- This includes hidden files and directories
			-- 		find_command = {
			-- 			"rg",
			-- 			"--files",
			-- 			"--no-ignore",
			-- 			"--glob",
			-- 			"!.git/*",
			-- 			"--glob",
			-- 			"!*.o",
			-- 		},
			-- 	})
			-- end)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
