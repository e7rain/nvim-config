return {
  'coffebar/neovim-project',
  keys = {
    {
      '<leader>fp',
      '<cmd>NeovimProjectDiscover<cr>',
      desc = '[P]roject',
    },
  },
  opts = {
    last_session_on_startup = false,
    -- Dashboard mode prevent session autoload on startup
    dashboard_mode = true,
    projects = { -- define project roots
      '~/.config/nvim',
      '~/Workspace/*',
      '~/Workspace/itg-dropshipping/packages/*',
      '~/Workspace/itg-product-enhancer/packages/*',
    },
    picker = {
      -- type = 'snacks',
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
}
