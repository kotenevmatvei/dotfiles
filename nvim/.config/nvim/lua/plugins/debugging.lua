return {
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			-- Keymaps
			vim.keymap.set("n", "<Leader>dc", function() dap.continue() end)
			vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end)
			vim.keymap.set("n", "<F10>", function() dap.step_over() end)
			vim.keymap.set("n", "<F11>", function() dap.step_into() end)
			vim.keymap.set("n", "<F12>", function() dap.step_out() end)
			vim.keymap.set("n", "<C-t>", ":DapTerminate<CR>", {})

			-----------------------------------------------------
			-- C / C++ Debugging Setup (cpptools)
			-----------------------------------------------------
			-- Dynamically get path to cpptools executable installed by Mason
			local cpptools_path = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"

			-- Define the adapter
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = cpptools_path,
			}

			-- Define the launch configurations
			dap.configurations.c = {
				{
					name = "Launch C executable",
					type = "cppdbg",
					request = "launch",
					program = function()
						-- Prompts you to input the path to the compiled binary
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					MIMode = "gdb", -- Usually gdb on Linux
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}

			-- Re-use the same configuration for C++
			dap.configurations.cpp = dap.configurations.c
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function(_, opts)
			-- Use vim.fn.expand to properly evaluate the tilde (~) into the home directory path
			local path = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
			require("dap-python").setup(path)
		end,
	},
}
