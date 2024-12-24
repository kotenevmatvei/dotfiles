return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "clangd", "ruff", "jedi_language_server" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({
        settings = {
          -- pyright = {
          --   disableOrganizeImports = true,
          -- },
          python = {
            analysis = {
              ignore = { "*" },
              autoSearchPaths = true,
            },
          },
        },
        capabilities = capabilities,
      })
      lspconfig.jedi_language_server.setup({
        on_attach = function(client)
          client.server_capabilities.hoverProvider = true
        end,
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        -- args = {
        --   "-I/usr/lib/x86_64-linux-gnu/mpich/include",
        --   "-L/usr/lib/x86_64-linux-gnu/mpich/lib",
        --   "-lmpi"
        -- },
        capabilities = capabilities,
      })
      lspconfig.ruff.setup({
        capabilities = capabilities,
      })
      -- Disable hover in favor of Pyright
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = "LSP: Disable hover capability from Ruff",
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>do", vim.lsp.buf.document_symbol, {})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, {})
    end,
  },
}
