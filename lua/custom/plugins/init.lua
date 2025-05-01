-- [[ General settings ]]

vim.opt.linebreak = true -- Keep words when wrapping
vim.opt.showbreak = '↪ '
vim.api.nvim_create_autocmd('VimEnter', { pattern = '*', command = 'lcd %:p:h' }) -- cd to opened directory

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
vim.keymap.set('n', '<leader>X', ':bufdo bd<CR>', { desc = 'Close all buffers' })
vim.keymap.set('n', 'gK', vim.diagnostic.open_float, { desc = 'Replace with repeat' })
-- Replace with repeat (https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/)
vim.keymap.set('v', 'gR', 'y<cmd>let @/=escape(@", \'/\')<cr>"_cgn', { desc = 'Replace with repeat' })

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

-- Line swapping (https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines)
vim.keymap.set('n', '<A-down>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-up>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-down>', '<ESC>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-up>', '<ESC>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-up>', ":m '<-2<CR>gv=gv")

-- [[ Languages ]]

-- Installation shortcut & documentation for used LSPs
vim.cmd [[ command! MyLspInstall lua MyLspInstall() ]]
function MyLspInstall()
  vim.cmd ':MasonInstall bash-language-server shellcheck shfmt'
  vim.cmd ':MasonInstall marksman markdownlint'
  vim.cmd ':MasonInstall json-lsp'
  vim.cmd ':MasonInstall prettier'
  vim.cmd ':MasonInstall dockerfile-language-server docker-compose-language-service'
end

-- Config for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,de_de'
  end,
})
require('conform').formatters_by_ft.markdown = { 'markdownlint' }
vim.filetype.add {
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
  },
}

-- [[ Additional Plugins ]]

return {
  { -- Switch text under cursor
    'AndrewRadev/switch.vim',
    config = function()
      vim.g.switch_custom_definitions = {
        { -- Cycle markdown checkboxes
          ['^\\(\\s*\\)- \\[ \\] \\(.*\\)'] = '\\1- [-] \\2',
          ['^\\(\\s*\\)- \\[-\\] \\(.*\\)'] = '\\1- [x] \\2',
          ['^\\(\\s*\\)- \\[x\\] \\(.*\\)'] = '\\1- \\2',
          ['^\\(\\s*\\)- \\(.*\\)'] = '\\1- [ ] \\2',
        },
        vim.keymap.set('n', '<C-return>', ':Switch<CR>'),
        vim.keymap.set('i', '<C-return>', '<ESC>:Switch<CR>A'),
      }
    end,
  },
}
