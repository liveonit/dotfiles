require("toggleterm").setup()

local Terminal = require('toggleterm.terminal').Terminal


function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-q>', [[<C-\><C-n>:q!<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')



function _lazygit_toggle()
  print(vim.fn.getcwd())
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = vim.fn.getcwd(),
    direction = "float",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  })
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })




function _htop_toggle()
  local htop = Terminal:new({
    cmd = "htop",
    dir = vim.fn.getcwd(),
    direction = "float",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  })
  htop:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _htop_toggle()<CR>", { noremap = true, silent = true })


local getPath = function(str, sep)
  sep = sep or '/'
  return str:match("(.*" .. sep .. ")")
end

function _pnpm_eslint_toggle()
  local pnpm_eslint = Terminal:new({
    cmd = string.format("es_linter.sh \"%s\"", getPath(vim.fn.expand('%:p'))),
    direction = "float",
    close_on_exit = true,
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
    on_stdout = function(term, job, data)
      for k, v in pairs(data) do
        if string.find(v, 'PATH: ') then
          vim.cmd("tabe " .. string.gsub(v:gsub('PATH: ', ''), "%s+", ""))
        end
      end
    end,
  })
  pnpm_eslint:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>te", "<cmd>lua _pnpm_eslint_toggle()<CR>", { noremap = true, silent = true })
