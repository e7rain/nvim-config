return {
  cmd = { 'DiffviewOpen' },
  'sindrets/diffview.nvim',
  keys = {
    -- stylua: ignore
    { '<leader>gD', '<Cmd>DiffviewOpen<CR>', desc = '[D]iffview', },
  },
  hooks = {
    diff_buf_read = function(bufnr)
      vim.b[bufnr].view_activated = false
    end,
  },
  config = function()
    require('diffview').setup {
      -- merge_tool = {
      --   layout = 'diff3_mixed',
      -- },
      keymaps = {
        view = {
          ['q'] = '<Cmd>DiffviewClose<CR>',
        },
        option_panel = {
          { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'Close the panel' } },
        },
        file_panel = {
          { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'Close the panel' } },
        },
      },
    }
  end,
}
