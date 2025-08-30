return {
  cmd = { 'DiffviewOpen' },
  'sindrets/diffview.nvim',
  hooks = {
    diff_buf_read = function(bufnr)
      vim.b[bufnr].view_activated = false
    end,
  },
  config = function()
    require('diffview').setup {
      keymaps = {
        view = {
          ['q'] = '<Cmd>DiffviewClose<CR>',
        },
        option_panel = {
          { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'Close the panel' } },
        },
      },
    }
  end,
}
