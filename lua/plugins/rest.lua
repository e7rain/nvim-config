return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  config = function()
    vim.g.rest_nvim = {
      ui = {
        winbar = true,
        keybinds = {
          prev = '[',
          next = ']',
        },
      },
    }

    vim.api.nvim_create_autocmd('filetype', {
      pattern = {
        'http',
      },
      callback = function(args)
        vim.keymap.set('n', '<leader>rr', '<cmd>Rest run<cr>', { buffer = args.buf, desc = '󱂛  request run' })
        vim.keymap.set('n', '<leader>rc', '<cmd>Rest curl yark<cr>', { buffer = args.buf, desc = '󱂛  request curl yark' })
      end,
    })
    require('telescope').load_extension 'rest'
  end,
}
