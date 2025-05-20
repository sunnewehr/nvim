vim.cmd [[ command! MyLspInstallCustom lua MyLspInstallCustom() ]]
function MyLspInstallCustom()
  vim.cmd ':MasonInstall gh-actions-language-server'
  vim.cmd ':MasonInstall terraform-ls'
  vim.cmd ':MasonInstall vue-language-server'
  vim.cmd ':MasonInstall yaml-language-server'
  vim.cmd ':MasonInstall taplo'
end

require('conform').formatters_by_ft.json = { 'prettier' }
require('conform').formatters_by_ft.javascript = { 'prettier' }
require('conform').formatters_by_ft.typescript = { 'prettier' }
require('conform').formatters_by_ft.vue = { 'prettier' }
require('conform').formatters_by_ft.yaml = { 'prettier' }

require('lspconfig').gh_actions_ls.setup {}

-- https://dev.to/danwalsh/solved-vue-3-typescript-inlay-hint-support-in-neovim-53ej
-- require('lspconfig').ts_ls.setup {
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--   init_options = {
--     plugins = {
--       {
--         name = '@vue/typescript-plugin',
--         location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
--         languages = { 'vue' },
--       },
--     },
--   },
-- }

require('lspconfig').volar.setup {
  init_options = { vue = { hybridMode = false } },
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        parameterTypes = { enabled = true, suppressWhenArgumentMatchesName = true },
        variableTypes = { enabled = true },
      },
    },
  },
}

require('lspconfig').ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
        languages = { 'vue' },
      },
    },
  },
  settings = {
    typescript = {
      tsserver = { useSyntaxServer = false },
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

return {}
