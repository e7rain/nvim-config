return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        {
          'igorlfs/nvim-dap-view',
          opts = {
            switchbuf = 'useopen',
            auto_toggle = true,
            winbar = {
              default_section = 'scopes',
            },

            windows = {
              terminal = {
                hide = { 'pwa-node' },
              },
            },
          },
        },
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
    },
    config = function()
      vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'toggle breakpoint' })
      vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'debugging debug' })
      vim.keymap.set('n', '<leader>dC', require('dap').run_to_cursor, { desc = 'run to cursor' })
      vim.keymap.set('n', '<leader>dt', require('dap').terminate, { desc = 'debug terminate' })
      vim.keymap.set('n', '<leader>dr', '<cmd>DapViewJump repl<CR>', { desc = 'debug repl toggle' })
      vim.keymap.set('n', '<leader>du', require('dap-view').toggle, { desc = 'Toggle nvim-dap-view' })
      vim.keymap.set('n', '<leader>dK', function()
        require('dap.ui.widgets').hover(nil, { border = 'single' })
      end, { desc = 'debug hover' })
      vim.keymap.set('n', '<leader>ds', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes, { border = 'single' })
      end, { desc = 'Window scopes' })
      vim.keymap.set('n', '<leader>dB', function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'breakpoint condition' })

      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpointCondition' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpointCondition' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })

      local dap, dap_view = require 'dap', require 'dap-view'
      -- dap.listeners.before.attach['dap-view-config'] = function()
      --   dap_view.open()
      -- end
      -- dap.listeners.before.launch['dap-view-config'] = function()
      --   dap_view.open()
      -- end
      dap.listeners.before.event_terminated['dap-view-config'] = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited['dap-view-config'] = function()
        dap_view.close()
      end

      dap.adapters.codelldb = {
        name = 'codelldb',
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
          args = { '${port}' },
        },
      }

      dap.adapters['pwa-chrome'] = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
      }

      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.adapters.netcoredbg = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net9.0/', 'file')
          end,
        },
      }

      -- Golang

      local config_chrome_debug = {
        {
          name = 'Chrome debug 9222',
          type = 'pwa-chrome',
          request = 'attach',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          port = 9222,
          webRoot = '${workspaceFolder}',
        },
      }

      local config_js_debug = {
        {
          name = 'Attach process',
          type = 'pwa-node',
          request = 'attach',
          skipFiles = {
            '<node_internals>/**',
            'node_modules/**',
          },
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
          address = '127.0.0.1',
          port = 9229,
          cwd = '${workspaceFolder}',
          protocol = 'inspector',
          restart = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file with tsx',
          cwd = '${workspaceFolder}',
          runtimeExecutable = 'pnpx',
          args = {
            'tsx',
            '${file}',
          },
          sourceMaps = true,
          protocol = 'inspector',
          skipFiles = {
            '<node_internals>/**',
            'node_modules/**',
          },
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          skipFiles = {
            '<node_internals>/**',
            'node_modules/**',
          },
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
          name = 'Launch',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }

      dap.configurations.c = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = true,
        },
      }

      dap.configurations.cpp = dap.configurations.c

      for _, filetype in pairs { 'javascript', 'typescript' } do
        dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {}, config_js_debug)
      end

      for _, filetype in pairs { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' } do
        dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {}, config_chrome_debug)
      end
    end,
  },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    opts = {},
  },
}
