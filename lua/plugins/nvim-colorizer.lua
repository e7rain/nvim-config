return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    -- filetypes = {
    --   'css',
    --   'javascript',
    --   'html',
    --   'blade',
    --   'php',
    --   'config'
    -- },
    user_default_options = {
      names = true,
      xterm = true,
      -- virtualtext_inline = true,
      mode = 'virtualtext',
      tailwind = true,
    },
  },
}
