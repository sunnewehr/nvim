-- [[ General settings ]]

vim.opt.linebreak = true -- Keep words when wrapping
vim.opt.showbreak = '↪ '

-- Enable folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 1000 -- Unfold when opening a file
vim.opt.foldtext = 'v:lua.MyFoldText()'
function MyFoldText()
  return string.format('%s [%d lines]', vim.fn.getline(vim.v.foldstart), vim.v.foldend - vim.v.foldstart + 1)
end

-- [[ Key bindings ]]

vim.keymap.set('i', 'jk', '<ESC>')

-- Visual line navigation
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('v', 'j', 'gj')
vim.keymap.set('v', 'k', 'gk')

-- Emacs bindings
vim.keymap.set('i', '<C-f>', '<right>')
vim.keymap.set('i', '<C-b>', '<left>')
vim.keymap.set('i', '<C-n>', '<down>')
vim.keymap.set('i', '<C-p>', '<up>')

-- Helix bindings
vim.keymap.set('n', '<C-s>', 'm`') -- <C-o> / <C-i> navigate the jump list
vim.keymap.set('n', 'gl', 'g$')
vim.keymap.set('n', 'gh', 'g^')
vim.keymap.set('v', 'gl', 'g$')
vim.keymap.set('v', 'gh', 'g^')

return {}
