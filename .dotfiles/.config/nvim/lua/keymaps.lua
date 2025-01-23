local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Split windows
keymap.set('n', 'ss', ':vsplit<Return>', opts)
keymap.set('n', 'sv', ':split<Return>', opts)

-- Save and quit window
vim.keymap.set('n', 'qq', ':q<Return>', { desc = 'Close window' })
vim.keymap.set('n', '<C-q>', ':q!<Return>', { desc = 'Close window' })
vim.keymap.set('n', '<C-s>', ':w<Return>', { desc = 'Save buffer' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<Return>li', { desc = 'Save buffer' })

-- Tabs
keymap.set('n', 'te', ':tabedit', opts)
keymap.set('n', '<tab>', ':tabnext<Return>', opts)
keymap.set('n', '<s-tab>', ':tabprev<Return>', opts)
keymap.set('n', '<leader><tab>d', ':tabclose<Return>', opts)

-- IncRename
-- vim.keymap.set('n', '<leader>cr', function()
--   return ':IncRename ' .. vim.fn.expand '<cword>'
-- end, { desc = 'LSP Rename', expr = true })

vim.keymap.set('n', '<S-K>', '<cmd>-20<CR>', { desc = 'Scroll up 20 lines' })
vim.keymap.set('n', '<S-J>', '<cmd>+20<CR>', { desc = 'Scroll down 20 lines' })

-- Show notifications history
keymap.set('n', '<leader>n', function()
  Snacks.notifier.show_history()
end, { desc = 'Notifications' })

-- Buffers
keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap.set('n', '<leader>br', function()
  Snacks.bufdelete()
end, { desc = 'Remove Buffer' })
keymap.set('n', '<leader>bo', function()
  Snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers' })
keymap.set(
  'n',
  '<leader>bd',
  '<cmd>:bd<cr>',
  { desc = 'Delete Buffer and Window' }
)
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank',
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Better indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')
