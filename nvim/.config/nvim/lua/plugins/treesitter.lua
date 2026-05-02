return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                indent = {
                    enable = true,
                    disable = { "c", "cpp" } -- Reverts back to stable C-indenting
                },
                auto_install = true,
                ensure_installed = {
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
                },
                highlight = { enable = true },
            })
        end
    }
}
