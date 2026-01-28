return {
  'folke/trouble.nvim',
  event = 'VeryLazy',
  cmd = { 'TroubleToggle', 'Trouble' },
  config = function()
    vim.keymap.set('n', '<leader>x', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>', { noremap = true, silent = true })
    require('trouble').setup {
      close = 'q', -- close the list
      cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
      use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
      picker = {
        actions = require('trouble.sources.snacks').actions,
        win = {
          input = {
            keys = {
              ['<c-t>'] = {
                'trouble_open',
                mode = { 'n', 'i' },
              },
            },
          },
        },
      },
    }
  end,
}
