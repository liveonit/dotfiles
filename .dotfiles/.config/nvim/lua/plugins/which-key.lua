local wk = require("which-key")

-- Configure Telescope to find files or find with ripgrep
-- REF:
--  - https://github.com/nvim-telescope/telescope.nvim
--  - https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
wk.add({
  { "<leader>f", group = "file", icon = "📁" }, -- group
  {
    "<leader>fg",
    "<cmd>lua require'telescope.builtin'.live_grep()<CR>",
    desc = "Live grep all files",
    mode = "n"
  },
  {
    "<leader>fb",
    "<cmd>Telescope buffers<CR>",
    desc = "Open Buffers",
    mode = "n"
  },
  {
    "<leader>ft",
    "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>",
    desc = "Document symbols",
    mode = "n"
  },
  {
    "<leader>?",
    "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    desc = "Fuzzy find in current buffer",
    mode = "n"
  },
  {
    "<leader>fs",
    "<cmd>lua require(\"telescope\").extensions.live_grep_args.live_grep_args()<CR>",
    desc = "Live grep with args",
    mode = "n"
  },
  {
    "<leader>ff",
    "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>",
    desc = "Find files",
    mode = "n"
  },
  {
    "<leader>fd",
    "<cmd>lua require'telescope.builtin'.git_files()<CR>",
    desc = "Find in git files",
    mode = "n"
  },
  {
    "<leader>fh",
    "<cmd>lua require'telescope.builtin'.oldfiles()<CR>",
    desc = "Open recent files",
    mode = "n"
  },
  {
    "<leader>fe",
    "<cmd>Telescope file_browser 'cwd=<C-R>=expand(\"%:p:h\")'<CR>",
    desc = "File browser home dir",
    mode = "n"
  },
  {
    "<leader>fc",
    "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
    desc = "File browser in current directory",
    mode = "n"
  }
})

wk.add({
  { "<leader>s", group = "Search" }, -- group
  {
    "<leader>sp",
    '<cmd>lua require("spectre").toggle()<CR>',
    desc = "Search in files",
    mode = "n"
  },
  {
    "<leader>sw",
    '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    desc = "Search word in files",
    mode = "n"
  },
  {
    "<leader>sw",
    '<esc><cmd>lua require("spectre").open_visual()<CR>',
    desc = "Search word in files",
    mode = "v"
  }
})


wk.add({
  { "<leader>x", group = "LSP/Trouble", icon = "🛠️" }, -- group
  {
    "<leader>xD",
    "<cmd>Trouble diagnostics toggle focus=true<CR>",
    desc = "Global Diagnostics (Trouble)",
  },
  {
    "<leader>xd",
    "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>",
    desc = "Buffer Diagnostics (Trouble)",
  },
  {
    "<leader>xs",
    "<cmd>Trouble symbols toggle focus=true pinned=true win.relative=win win.position=right<CR>",
    desc = "Symbols (Trouble)",
  },
  {
    "<leader>xl",
    "<cmd>Trouble loclist toggle<CR>",
    desc = "Location List (Trouble)",
  },
  {
    "<leader>xq",
    "<cmd>Trouble qflist toggle<CR>",
    desc = "Quickfix List (Trouble)",
  },
  {
    "<leader>xh",
    "<cmd>lua vim.lsp.buf.hover()<CR>",
    desc = "Hover (LSP)",
  },
  {
    "<leader>xi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    desc = "Go to implementation (LSP)",
  },
  {
    "<leader>xf",
    "<cmd>lua vim.lsp.buf.format()<CR>",
    desc = "Format buffer (LSP)",
  },
  {
    "<leader>xc",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    desc = "Show code actions (LSP)",
  },
  {
    "<leader>xa",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    desc = "Show signature help (LSP)",
  },
  {
    "<leader>xp",
    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    desc = "Go to prev (diagnostic)",
  },
  {
    "<leader>xn",
    "<cmd>lua vim.diagnostic.goto_next()<cr>",
    desc = "Go to next (diagnostic)",
  }
})
