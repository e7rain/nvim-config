vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}

return {
  'mistweaverco/kulala.nvim',
  keys = {
    {
      '<leader>rr',
      function()
        require('kulala').run()
      end,
      desc = 'Run request',
    },
    {
      '<leader>ra',
      function()
        require('kulala').run_all()
      end,
      desc = 'Run all request',
    },
    {
      '<leader>rc',
      function()
        require('kulala').copy()
      end,
      desc = 'Copy request to clipboard',
    },
    {
      '<leader>rp',
      function()
        require('kulala').from_curl()
      end,
      desc = 'Paste request from curl',
    },
    {
      '<leader>re',
      function()
        require('kulala').set_selected_env()
      end,
      desc = 'Set environment variables',
    },
    {
      '<leader>rC',
      function()
        require('kulala').clear_cached_files()
      end,
      desc = 'Clear cache files',
    },
  },
  ft = { 'http', 'rest' },
  opts = {
    lsp = {
      filetypes = { 'http', 'rest', 'json', 'yaml', 'javascript' },
    },
    ui = {
      -- default_view = 'headers_body',
      max_response_size = 256000,
      win_opts = {
        wo = {
          foldlevel = 1,
        },
      },
      icons = {
        inlay = {
          loading = '󰔟 ',
          done = ' ',
          error = ' ',
        },

        lualine = '🐼',
        textHighlight = 'WarningMsg',
        lineHighlight = 'Normal',
      },
    },
    global_keymaps = false,
    kulala_keymaps = {

      ['Show headers'] = {
        'H',
        function()
          require('kulala.ui').show_headers()
        end,
      },
      ['Show body'] = {
        'B',
        function()
          require('kulala.ui').show_body()
        end,
      },
      ['Show headers and body'] = {
        'A',
        function()
          require('kulala.ui').show_headers_body()
        end,
      },
      ['Show verbose'] = {
        'L',
        function()
          require('kulala.ui').show_verbose()
        end,
      },
      ['Show script output'] = {
        'O',
        function()
          require('kulala.ui').show_script_output()
        end,
      },
      ['Show stats'] = {
        'S',
        function()
          require('kulala.ui').show_stats()
        end,
      },
      ['Show report'] = {
        'R',
        function()
          require('kulala.ui').show_report()
        end,
      },
      ['Show filter'] = {
        'F',
        function()
          require('kulala.ui').toggle_filter()
        end,
      },
    },
  },
}
