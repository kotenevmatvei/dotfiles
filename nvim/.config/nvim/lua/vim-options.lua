vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set colorcolumn=90")
vim.g.mapleader = " "

vim.opt.swapfile = false

vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Up>", ":horizontal resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":horizontal resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "<leader>ee", ":lua vim.diagnostic.setqflist()<CR>")
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })

-- Obsidian --
vim.keymap.set("n", "<leader>n", ":ObsidianNew<CR>")
vim.keymap.set("n", "<C-p>", ":ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>d", ":ObsidianNewFromTemplate<CR>")
vim.keymap.set("n", "<leader>ch", ":ObsidianToggleCheckbox<CR>", { noremap = true, silent = true })

-- LSP
-- Your keymaps and autocommands are safe to keep here
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>do", vim.lsp.buf.document_symbol, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, {})

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true
