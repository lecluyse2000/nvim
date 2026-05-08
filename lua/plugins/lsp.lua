return {
   "neovim/nvim-lspconfig",
   dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
   },
   lazy = false,
   config = function()
      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

      vim.api.nvim_create_autocmd('LspAttach', {
         desc = 'LSP actions',
         callback = function(event)
            local opts = { buffer = event.buf }

            -- these will be buffer-local keybindings
            -- because they only work if you have an active language server

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
         end
      })

      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local lsp_capabilities = vim.tbl_deep_extend(
         "force",
         {},
         vim.lsp.protocol.make_client_capabilities(),
         cmp_lsp.default_capabilities())

      local default_setup = function(server)
         require('lspconfig')[server].setup({
            capabilities = lsp_capabilities,
            on_init = function(client)
               client.server_capabilities.semanticTokensProvider = nil
            end,
         })
      end

      require('mason').setup({})
      require('mason-lspconfig').setup({
         ensure_installed = {
            "lua_ls",
            "neocmake",
            "autotools_ls",
            "clangd",
            "marksman",
            "pyright" },
         handlers = {
            default_setup,
            lua_ls = function()
               require('lspconfig').lua_ls.setup({
                  capabilities = lsp_capabilities,
                  settings = {
                     Lua = {
                        runtime = {
                           version = 'LuaJIT'
                        },
                        diagnostics = {
                           globals = { 'vim' },
                        },
                        workspace = {
                           library = {
                              vim.env.VIMRUNTIME,
                           }
                        }
                     }
                  }
               })
            end,
         },
      })
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
         sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
         }, {
            { name = 'buffer' },
         }),
         mapping = cmp.mapping.preset.insert({
            ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
         }),
         snippet = {
            expand = function(args)
               require('luasnip').lsp_expand(args.body)
            end,
         },
      })
   end
}
