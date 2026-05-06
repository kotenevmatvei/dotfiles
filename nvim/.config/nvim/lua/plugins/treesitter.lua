return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- Switch to the new main branch for Neovim 0.12+ compatibility
        branch = "main",
        build = ":TSUpdate",
        config = function()
            -- Change the require statement to the new main module
            local ts = require("nvim-treesitter")

            -- Call the new setup module (which now just initializes defaults)
            ts.setup({})

            -- Use the new install module directly for parsers
            ts.install({
                "bash",
                "html",
                "css",
                "scss",
                "javascript",
                "typescript",
                "json",
                "lua",
                "python",
                "c",
                "cpp",
            })

            -- Create an autocmd to automatically attach Tree-sitter for highlighting
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    local filetype = vim.bo.filetype
                    if filetype and filetype ~= "" then
                        pcall(vim.treesitter.start)
                    end
                end,
            })

            -- Setup Tree-sitter indenting handling directly via Neovim options
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    }
}
