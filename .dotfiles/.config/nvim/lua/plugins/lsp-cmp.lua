local navic = require("nvim-navic")
local lsp_zero = require("lsp-zero")


lsp_zero.on_attach(function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "ansiblels",
    "rust_analyzer",
    "ts_ls",
    "bashls",
    "cssls",
    "cmake",
    "dockerls",
    "eslint",
    "graphql",
    "html",
    "helm_ls",
    "jsonls",
    "lua_ls",
    "prosemd_lsp",
    "pyright",
    "sqlls",
    "terraformls"
  },
  automatic_installation = true,
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = "nvim_lsp",                group_index = 2 },
    { name = "path",                    group_index = 2 },
    { name = "nvim_lua",                group_index = 2 },
    { name = 'nvim_lsp_signature_help', group_index = 2 }
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-a>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
})
