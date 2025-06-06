return {
  {
    'olimorris/codecompanion.nvim',
    config = function()
      require('codecompanion').setup {
        display = { chat = { intro_message = '' } },
        opts = { system_prompt = '' },
        strategies = {
          chat = {
            adapter = 'openai',
            keymaps = {
              send = {
                -- Disable enter to send in normal mode
                modes = { n = '<C-s>', i = '<C-s>' },
                -- Exit insert mode after submitting
                callback = function(chat)
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
                  chat:submit()
                end,
              },
            },
          },
          cmd = { adapter = 'openai' },
          inline = { adapter = 'openai' },
        },
      }
      -- Open a new chat as a single buffer without a system prompt
      vim.cmd [[ command! MyChat lua MyChat() ]]
      function MyChat()
        local cc = require 'codecompanion'
        cc.chat()
        vim.cmd 'wincmd w'
        vim.cmd 'q'
        vim.cmd 'startinsert'
      end
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
