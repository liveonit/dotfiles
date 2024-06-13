local luasnip = require("luasnip")
local navic = require("nvim-navic")
local lsp_zero = require("lsp-zero")


lsp_zero.on_attach(function(client, bufnr)
  local opts = { noremap = true, silent = true }

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- Troube mappings
  buf_set_keymap("n", "<leader>vD", "<cmd>TroubleToggle lsp_type_definitions<CR>", opts)
  buf_set_keymap("n", "<leader>vd", "<cmd>TroubleToggle lsp_definitions<CR>", opts)
  buf_set_keymap("n", "<leader>vr", "<cmd>TroubleToggle lsp_references<CR>", opts)
  buf_set_keymap("n", "<leader>vq", "<cmd>TroubleToggle quickfix<cr>", opts)
  buf_set_keymap("n", "<leader>vt", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
  -- LSP mappings
  buf_set_keymap("n", "<leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<leader>vf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  buf_set_keymap("n", "<leader>vc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- Diagnostic mappings
  buf_set_keymap("n", "<leader>vp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
  buf_set_keymap("n", "<leader>vn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
  buf_set_keymap("n", "<C-d>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "ansiblels",
    "rust_analyzer",
    "tsserver",
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
    -- Copilot Source
    -- { name = "copilot",                 group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp",                group_index = 2 },
    { name = "path",                    group_index = 2 },
    { name = "luasnip",                 group_index = 2 },
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
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
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
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
})
