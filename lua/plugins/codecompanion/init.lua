return {
  'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- {
    --   'ravitemer/mcphub.nvim',
    --   dependencies = {
    --     'nvim-lua/plenary.nvim',
    --   },
    --   build = 'npm install -g mcp-hub@latest',
    --   config = function()
    --     require('mcphub').setup {
    --       global_env = {
    --         -- vtex mcp
    --         'BASE_URL',
    --         'APP_KEY',
    --         'APP_TOKEN',
    --       },
    --     }
    --   end,
    -- },
    'franco-ruggeri/codecompanion-spinner.nvim',
  },
  keys = {
    -- stylua: ignore start
    { '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'Codecompanion chat' },
    { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'Codecompanion actions', },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = { 'v' }, desc = 'Codecompanion chat add selection', },
  },
  -- stylua: ignore end
  opts = {
    ignore_warnings = true,
    display = {
      action_palette = {
        provider = 'snacks',
        opts = {
          show_default_actions = false,
          show_default_prompt_library = true,
        },
      },
    },
    extensions = require 'plugins.codecompanion.extensions',
    prompt_library = require 'plugins.codecompanion.prompt_library',
    opts = {
      language = 'Español',
    },
    adapters = require 'plugins.codecompanion.adapters',
    strategies = require 'plugins.codecompanion.strategies',
  },
}
