local null_ls = require('null-ls')

null_ls.setup({
  on_attach = function(client, bufnr)
    local format_files = { 'python', 'lua', 'bash', 'csh', 'ksh', 'sh', 'zsh' }

    if vim.tbl_contains(format_files, vim.bo.filetype) then
      require('lsp-zero').async_autoformat(client, bufnr)
    end
  end,
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.beautysh
  },
})
