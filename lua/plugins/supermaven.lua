return {
  'supermaven-inc/supermaven-nvim',
  event = 'VeryLazy',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<C-]>',
        clear_suggestion = '<C-x>',
        accept_word = '<C-j>',
      },
    }
  end,
}
