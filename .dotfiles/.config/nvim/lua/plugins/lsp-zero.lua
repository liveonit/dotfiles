local lsp = require("lsp-zero")
local luasnip = require 'luasnip'

lsp.preset("recommended")

lsp.ensure_installed({
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
  'terraformls',
  'shfmt'
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-a>"] = cmp.mapping.complete(),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })

})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = {
    error = '❌',
    warn = '⚠️',
    hint = '🪄',
    info = 'ℹ️'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { noremap = true, silent = true }

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Troube mappings
  buf_set_keymap('n', '<leader>vD', '<cmd>TroubleToggle lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', '<leader>vd', '<cmd>TroubleToggle lsp_definitions<CR>', opts)
  buf_set_keymap('n', '<leader>vr', '<cmd>TroubleToggle lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>vq', '<cmd>TroubleToggle quickfix<cr>', opts)
  buf_set_keymap('n', '<leader>vt', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
  -- LSP mappings
  buf_set_keymap('n', "<leader>vh", '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>vf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', "<leader>vc", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- Diagnostic mappings
  buf_set_keymap('n', '<leader>vp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', '<leader>vn', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<C-d>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
