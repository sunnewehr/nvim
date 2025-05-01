return {
  {
    'olimorris/codecompanion.nvim',
    config = function()
      require('codecompanion').setup {
        display = { chat = { intro_message = '' } },
        strategies = {
          chat = {
            adapter = 'openai',
            keymaps = {
              send = {
                -- Disable enter to send in normal mode
                modes = { n = '<C-s>', i = '<C-s>' },
                index = 2,
                -- Exit insert mode after submitting
                callback = function(chat)
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
                  chat:submit()
                end,
                description = 'Send',
              },
            },
          },
          cmd = { adapter = 'openai' },
          inline = { adapter = 'openai' },
        },
      }
      vim.keymap.set('n', '<leader>c', ':CodeCompanionChat Toggle<CR>', { desc = '[C]hat' })
      vim.keymap.set('v', '<leader>c', ':CodeCompanionChat<CR>', { desc = '[C]hat' })
      vim.keymap.set('v', 'gC', ':CodeCompanion /buffer ')
      -- Open a new chat as a single buffer without a system prompt
      vim.cmd [[ command! MyChat lua MyChat() ]]
      function MyChat()
        local cc = require 'codecompanion'
        cc.chat()
        cc.last_chat().toggle_system_prompt(cc.last_chat())
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
