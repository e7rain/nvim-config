return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  opts = {},
  keys = {
    -- stylua: ignore start
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash', },
    { 'S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter', },
    { 'r', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search', },
    { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search', },
    -- stylua: ignore end
  },
}
