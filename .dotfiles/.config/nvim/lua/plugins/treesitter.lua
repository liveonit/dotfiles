-- NVIM Treesitter --
-- REF:
--  - https://github.com/nvim-treesitter/nvim-treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash", "css", "dockerfile", "go", "gomod", "gowork", "graphql", "html", "http", "javascript", "jsdoc", "json",
    "json5", "jsonc", "lua", "make", "markdown", "python", "regex", "rust", "ruby",
    "tsx", "typescript", "vim", "yaml"
  },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  autopairs = { enable = true },
  indent = { enabe = true },
});

