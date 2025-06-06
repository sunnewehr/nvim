-- [[ General settings ]]

vim.opt.linebreak = true -- Keep words when wrapping
vim.opt.showbreak = '↪ '

-- Enable folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 1000 -- Unfold when opening a file

-- [[ Key bindings ]]

vim.keymap.set('i', 'jk', '<ESC>')
-- Prevent accidental input
vim.keymap.set('v', 'J', 'j')
vim.keymap.set('v', 'K', 'k')

-- Helix bindings
vim.keymap.set('n', '<C-s>', 'm`') -- <C-o> / <C-i> navigate the jump list
vim.keymap.set('v', 'R', 'p')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gs', '^')
vim.keymap.set('v', 'gl', '$')
vim.keymap.set('v', 'gh', '0')
vim.keymap.set('v', 'gs', '^')

-- Emacs bindings
vim.keymap.set('i', '<C-f>', '<right>')
vim.keymap.set('i', '<C-b>', '<left>')
vim.keymap.set('i', '<C-n>', '<down>')
vim.keymap.set('i', '<C-p>', '<up>')

return {
  {
    'easymotion/vim-easymotion',
    config = function()
      vim.keymap.set('n', 'gw', '<Plug>(easymotion-bd-w)')
    end,
  },
}
