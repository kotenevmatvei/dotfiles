-- Enable absolute line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true
-- disable showmode, since already visible in lualine
vim.opt.showmode = false
-- and remove the unnecessary space
vim.opt.cmdheight = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")


-- In your ~/.config/nvim/init.lua

local markdown_augroup = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = markdown_augroup,
    pattern = 'markdown',
    callback = function()
        -- This function defers our settings to make sure they are applied last
        vim.schedule(function()
            -- Soft wrapping that breaks on words
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true

            -- THE FIX: Use operators to modify the formatoptions string
            vim.opt_local.formatoptions = vim.opt_local.formatoptions - 't' -- Remove auto-wrap
            vim.opt_local.formatoptions = vim.opt_local.formatoptions - 'c' -- Remove auto-wrap for comments
            vim.opt_local.formatoptions = vim.opt_local.formatoptions + 'n' -- Add smart list formatting

            -- Visual guide for typing, does not force wrapping
            vim.opt_local.textwidth = 80
            vim.opt_local.colorcolumn = '0'

            -- Intuitive up/down navigation for wrapped lines
            vim.keymap.set('n', 'j', 'gj', { buffer = true, silent = true })
            vim.keymap.set('n', 'k', 'gk', { buffer = true, silent = true })
        end)
    end,
})

-- Add this to your init.lua
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "/Users/matveikotenev/Documents/obsidian*",
    command = "!/Users/matveikotenev/.config/scripts/obsidian_push.sh",
})
