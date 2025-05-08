-- [[ General settings ]]

vim.opt.linebreak = true -- Keep words when wrapping
vim.opt.showbreak = '↪ '
vim.api.nvim_create_autocmd('VimEnter', { pattern = '*', command = 'lcd %:p:h' }) -- cd to opened directory

-- [[ Key bindings ]]

-- Exit insert mode
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

-- Line swapping (https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines)
vim.keymap.set('n', '<A-down>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-up>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-down>', '<ESC>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-up>', '<ESC>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-up>', ":m '<-2<CR>gv=gv")

-- Leader bindings
require('mini.files').setup()
vim.keymap.set('n', '<leader>e', MiniFiles.open, { desc = 'File [E]xplorer' })
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Search by [G]rep' })
vim.keymap.set('n', '<leader>r', function()
  builtin.oldfiles { only_cwd = true }
end, { desc = '[R]ecent Files' })
vim.keymap.set('n', "<leader>'", builtin.resume, { desc = 'Search Resume' })
-- Replace selection and use . or n to continue
-- https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
vim.keymap.set('v', '<leader>c', 'y<cmd>let @/=escape(@", \'/\')<cr>"_cgn', { desc = '[C]hance selection with repeat' })

-- [[ Languages ]]

-- Markdown
vim.g.markdown_folding = 1
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.foldlevel = 1000 -- Unfold when opening a file
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,de_de'
  end,
})
require('conform').formatters_by_ft.markdown = { 'markdownlint' }

-- LSPs
vim.cmd [[ command! MyLspInstall lua MyLspInstall() ]]
function MyLspInstall()
  vim.cmd ':MasonInstall bash-language-server shellcheck shfmt'
  vim.cmd ':MasonInstall marksman markdownlint'
  vim.cmd ':MasonInstall json-lsp'
  vim.cmd ':MasonInstall prettier'
  vim.cmd ':MasonInstall gh-actions-language-server'
  vim.cmd ':MasonInstall terraform-ls'
end
require('lspconfig').gh_actions_ls.setup {}

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
