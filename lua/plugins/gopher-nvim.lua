return {
  'olexsmir/gopher.nvim',
  ft = 'go',
  build = function()
    vim.cmd.GoInstallDeps()
  end,
  config = function()
    require('gopher').setup()
  end,
}
