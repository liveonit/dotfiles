require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'ansiblels',
    'rust_analyzer',
    'tsserver',
    'bashls',
    'cssls',
    'cmake',
    'dockerls',
    'eslint',
    'graphql',
    'html',
    'helm_ls',
    'jsonls',
    'lua_ls',
    'prosemd_lsp',
    'pyright',
    'sqlls',
    'terraformls'
  },
  automatic_installation = true,
})

local lsp = require('lsp-zero')
lsp.extend_cmp()



require('lspconfig').tsserver.setup({
  on_attach = function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
  end
})