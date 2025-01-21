local wk = require("which-key")
local dap = require("dap")
local utils = require("utils")


-- Configure Telescope to find files or find with ripgrep
-- REF:
--  - https://github.com/nvim-telescope/telescope.nvim
--  - https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
-- INFO: ./telescope.lua and should be previously imported
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

-- Search
wk.add({
  { "<leader>s", group = "Search", icon = "🔎" }, -- group
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

-- LSP and Trouble
-- INFO: ./lsp-cmp.lua and ./trouble.lua should be previously imported
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
    "<leader>xD",
    "<cmd>Trouble lsp_type_definitions<CR>",
    desc = "LSP type definitions"
  },
  {
    "<leader>xd",
    "<cmd>Trouble lsp_definitions<CR>",
    desc = "LSP definitions"
  },
  {
    "<leader>xr",
    "<cmd>Trouble lsp_references<CR>",
    desc = "LSP references"
  },
  {
    "<leader>xf",
    desc = "Format buffer (LSP)",
    "<cmd>lua vim.lsp.buf.format()<CR>",
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

wk.add({
  {
    "<C-d>",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    desc = "Diagnostic open float"
  }
})


-- Debug
-- INFO: ./debuging.lua should be previously imported
wk.add({
  { "<leader>d", group = "Debug", icon = "🪲" }, -- group
  {
    "<leader>dc",
    function()
      local launch_config_dir = utils.find_ancestor_with_file("launch.json")
      if launch_config_dir and utils.get_file_extension(vim.fn.expand("%:p")) == "ts" then
        local launch_config = utils.read_and_parse_json_file(launch_config_dir .. "/launch.json")
        if not (utils.table_contains_by_attribute(dap.configurations.typescript, "name", launch_config.name)) then
          dap.configurations.typescript[#dap.configurations.typescript + 1] = launch_config
        end
      end

      if launch_config_dir and utils.get_file_extension(vim.fn.expand("%:p")) == "js" then
        dap.configurations.javascript[#dap.configurations.javascript + 1] = utils.read_and_parse_json_file(
          launch_config_dir ..
          "/launch.json")
      end

      dap.continue()
    end,
    desc = "Start or continue (debug)",
  },
  { '<leader>dj', dap.step_over, desc = "Step Over (Debug)" },
  { '<leader>dl', dap.step_into, desc = "Step Into (Debug)" },
  { '<leader>dh', dap.step_out, desc = "Step Out (Debug)" },
  { '<leader>db', dap.toggle_breakpoint, desc = "Toggle Breakpoint (Debug)" },
  {
    '<leader>dB',
    function()
      require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end,
    desc = "Toggle Breakpoint (Debug)"
  }
})


-- Terminal
-- INFO: ./toggleterm.lua should be previously imported
wk.add({
  { "<leader>t", group = "Terminal", icon = "💻" }, -- group
  {
    "<leader>tg",
    "<cmd>lua open_lazygit_terminal()<CR>",
    desc = "Open Lazygit (terminal)",
  },
  {
    "<leader>tc",
    "<cmd>lua open_htop_terminal()<CR>",
    desc = "Open HTOP (terminal)",
  },
  {
    "<leader>te",
    "<cmd>lua open_pnpm_eslint_terminal()<CR>",
    desc = "Execute eslint in the current buffer project and summarize result (terminal)",
  }
})


-- TODO comments
-- INFO: ./todo-comments.lua and ./telescope.lua should be previously imported
wk.add({
  { "<leader>c", group = "TODO comments", icon = "☎️" },
  {
    "<leader>cn",
    function()
      require("todo-comments").jump_next()
    end,
    desc = "Next (TODO comment)"
  },
  {
    "<leader>cp",
    function()
      require("todo-comments").jump_prev()
    end,
    desc = "Previous (TODO comment)"
  },
  {
    "<leader>ce",
    function()
      require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
    end,
    desc = "Next error/warning (TODO comment)"
  },
  {
    "<leader>ct",
    function()
      require("todo-comments").jump_next({ keywords = { "TODO", "FIXME" } })
    end,
    desc = "Next todo/fixme (TODO comment)"
  },
  {
    "<leader>cf",
    "<cmd>TodoTelescope<CR>",
    desc = "Find todos (TODO comment - Telescope)"
  }

})


-- ChatGPT
wk.add({
  { "<leader>g", group = "ChatGPT", icon = "🤖" }, -- group
  {
    "<leader>c",
    "<cmd>ChatGPT<CR>",
    desc = "Open ChatGPT",
  },
  {
    "<leader>e",
    "<cmd>ChatGPTEditWithInstructions<CR>",
    desc = "ChatGPT - Edit with instruction",
    mode = { "n", "v" },
  },
  {
    "<leader>g",
    "<cmd>ChatGPTRun grammar_correction<CR>",
    desc = "ChatGPT - Grammar Correction",
    mode = { "n", "v" },
  },
  {
    "<leader>t",
    "<cmd>ChatGPTRun translate<CR>",
    desc = "ChatGPT - Translate",
    mode = { "n", "v" },
  },
  {
    "<leader>k",
    "<cmd>ChatGPTRun keywords<CR>",
    desc = "ChatGPT - Keywords",
    mode = { "n", "v" }
  },
  {
    "<leader>d",
    "<cmd>ChatGPTRun docstring<CR>",
    desc = "ChatGPT - Docstring",
    mode = { "n", "v" }
  },
  {
    "<leader>a",
    "<cmd>ChatGPTRun add_tests<CR>",
    desc = "ChatGPT - Add Tests",
    mode = { "n", "v" }
  },
  {
    "<leader>o",
    "<cmd>ChatGPTRun optimize_code<CR>",
    desc = "ChatGPT - Optimize Code",
    mode = { "n", "v" }
  },
  {
    "<leader>s",
    "<cmd>ChatGPTRun summarize<CR>",
    desc = "ChatGPT - Summarize",
    mode = { "n", "v" }
  },
  {
    "<leader>f",
    "<cmd>ChatGPTRun fix_bugs<CR>",
    desc = "ChatGPT - Fix Bugs",
    mode = { "n", "v" }
  },
  {
    "<leader>x",
    "<cmd>ChatGPTRun explain_code<CR>",
    desc = "ChatGPT - Explain Code",
    mode = { "n", "v" }
  },
  {
    "<leader>r",
    "<cmd>ChatGPTRun roxygen_edit<CR>",
    desc = "ChatGPT - Roxygen Edit",
    mode = { "n", "v" }
  },
  {
    "<leader>l",
    "<cmd>ChatGPTRun code_readability_analysis<CR>",
    desc = "ChatGPT - Code Readability Analysis",
    mode = { "n", "v" }
  },
})
