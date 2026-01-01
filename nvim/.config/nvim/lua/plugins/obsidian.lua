-- Okay, what I want to be able to do:
-- 1. With a shortcut create a note (title passed as a parameter) and automatically
--    assign a unique, time-based ID and title property same as title.
-- 2. DO NOT CREATE NOTES ANY OTHER WAY E.G. VIA NEOTREE OR CONSOLE

return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {

		workspaces = {
			{
				name = "obsidian",
				path = "~/Documents/obsidian",
			},
		},

		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},

		templates = {
			folder = "Templates",
		},

		-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
		-- way then set 'mappings = {}'.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
		},

		ui = {
			enable = true, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			max_file_length = 5000, -- disable UI features for files with more than this many lines
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				["!"] = { char = "", hl_group = "ObsidianImportant" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},
			-- Use bullet marks for non-checkbox lists.
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			-- Replace the above with this if you don't have a patched font:
			-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#ff5370" },
				ObsidianImportant = { bold = true, fg = "#d73128" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianBlockID = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},
		-- This function defines the default frontmatter for NEW notes.
		-- It's executed only when a new note is created.
		---@return table
		note_frontmatter_func = function(note)
			-- `note.metadata` contains any fields passed to `:ObsidianNew`
			-- so we can merge them with our defaults.
			local out = {
				-- Set the creation and last updated dates.
				created = os.date("%Y-%m-%d@%H:%M:%S"),
				last_updated = os.date("%Y-%m-%d@%H:%M:%S"),
			}

			-- Merge any metadata passed during note creation.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,

		note_id_func = function(title)
			return title
		end,

		-- This table defines callbacks that are triggered on certain events.
		callbacks = {
			-- This callback is triggered right before a note is written to disk.
			---@param client obsidian.Client
			---@param note obsidian.Note
			pre_write_note = function(client, note)
				-- This function will find the 'last_updated' field in the note's
				-- frontmatter and update it with the current timestamp.
				-- If the field doesn't exist, it will be added.
				note:add_field("last_updated", os.date("%Y-%m-%d@%H:%M:%S"))
			end,
		},

		-- see below for full list of options 👇
	},

	config = function(_, opts)
		-- This will run the default setup function
		require("obsidian").setup(opts)

		-- Set conceallevel FOR MARKDOWN BUFFERS ONLY
		vim.opt.conceallevel = 0

		local client = require("obsidian").get_client()
		vim.keymap.set("n", "<leader>n", ":ObsidianNew<CR>")
		vim.keymap.set("n", "<C-p>", ":ObsidianQuickSwitch<CR>")
		vim.keymap.set("n", "<leader>d", ":ObsidianNewFromTemplate<CR>")
	end,
}
