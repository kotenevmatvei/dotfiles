return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",

  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>')

    require('neo-tree').setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false, -- Show hidden files (e.g., .git, .vimrc)
          hide_gitignored = false, -- Optionally, show git ignored files
        },
      },
    })
  end

}

