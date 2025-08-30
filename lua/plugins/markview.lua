return {
  'OXY2DEV/markview.nvim',
  ft = { 'markdown', 'codecompanion' },
  cmd = { 'Markview' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('markview').setup {
      preview = {
        filetypes = { 'markdown', 'codecompanion' },
        ignore_buftypes = {},
      },
    }
  end,
}
