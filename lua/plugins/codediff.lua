return {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
  keys = {
    -- stylua: ignore
    { 'dv', '<cmd>CodeDiff<cr>', desc = '[D]iff toggle', },
  },
  config = function()
    require('codediff').setup {}
  end,
  init = function()
    vim.cmd [[cab dd CodeDiff]]
  end,
}
