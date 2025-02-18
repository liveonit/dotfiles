-- When using ChatGPT and ChatGPTEditWithInstructions, the following keybindings are available:
--
-- <C-Enter> [Both] to submit.
-- <C-y> [Both] to copy/yank last answer.
-- <C-o> [Both] Toggle settings window.
-- <C-h> [Both] Toggle help window.
-- <Tab> [Both] Cycle over windows.
-- <C-f> [Chat] Cycle over modes (center, stick to right).
-- <C-c> [Both] to close chat window.
-- <C-p> [Chat] Toggle sessions list.
-- <C-u> [Chat] scroll up chat window.
-- <C-d> [Chat] scroll down chat window.
-- <C-k> [Chat] to copy/yank code from last answer.
-- <C-n> [Chat] Start new session.
-- <C-r> [Chat] draft message (create message without submitting it to server)
-- <C-r> [Chat] switch role (switch between user and assistant role to define a workflow)
-- <C-s> [Both] Toggle system message window.
-- <C-i> [Edit Window] use response as input.
-- <C-d> [Edit Window] view the diff between left and right panes and use diff-mode commands
--

return {
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup {
        api_key_cmd = 'secman -a get -n GPT_SECRET_API_KEY',
        openai_params = {
          -- NOTE: model can be a function returning the model name
          -- this is useful if you want to change the model on the fly
          -- using commands
          -- Example:
          -- model = function()
          --     if some_condition() then
          --         return "gpt-4-1106-preview"
          --     else
          --         return "gpt-3.5-turbo"
          --     end
          -- end,
          model = 'gpt-4o',
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
      }
    end,
    keys = {
      {
        '<leader>hc',
        '<cmd>ChatGPT<CR>',
        desc = 'Open ChatGPT',
      },
      {
        '<leader>he',
        '<cmd>ChatGPTEditWithInstructions<CR>',
        desc = 'ChatGPT - Edit with instruction',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hg',
        '<cmd>ChatGPTRun grammar_correction<CR>',
        desc = 'ChatGPT - Grammar Correction',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ht',
        '<cmd>ChatGPTRun translate<CR>',
        desc = 'ChatGPT - Translate',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hk',
        '<cmd>ChatGPTRun keywords<CR>',
        desc = 'ChatGPT - Keywords',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hd',
        '<cmd>ChatGPTRun docstring<CR>',
        desc = 'ChatGPT - Docstring',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ha',
        '<cmd>ChatGPTRun add_tests<CR>',
        desc = 'ChatGPT - Add Tests',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ho',
        '<cmd>ChatGPTRun optimize_code<CR>',
        desc = 'ChatGPT - Optimize Code',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hs',
        '<cmd>ChatGPTRun summarize<CR>',
        desc = 'ChatGPT - Summarize',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hf',
        '<cmd>ChatGPTRun fix_bugs<CR>',
        desc = 'ChatGPT - Fix Bugs',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hx',
        '<cmd>ChatGPTRun explain_code<CR>',
        desc = 'ChatGPT - Explain Code',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hr',
        '<cmd>ChatGPTRun roxygen_edit<CR>',
        desc = 'ChatGPT - Roxygen Edit',
        mode = { 'n', 'v' },
      },
      {
        '<leader>hl',
        '<cmd>ChatGPTRun code_readability_analysis<CR>',
        desc = 'ChatGPT - Code Readability Analysis',
        mode = { 'n', 'v' },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim', -- optional
      'nvim-telescope/telescope.nvim',
    },
  },
}
