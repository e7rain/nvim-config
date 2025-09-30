return {
  {
    'nvim-neotest/neotest',
    -- version = 'v5.9.1',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
      {
        'fredrikaverpil/neotest-golang',
        version = '1.15.1', -- Optional, but recommended
        dependencies = {
          'leoluz/nvim-dap-go',
          opts = {},
        },
        build = function()
          vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait() -- Optional, but recommended
        end,
      },
      'nsidorenco/neotest-vstest',
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup {
        floating = {
          -- border = 'solid',
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },

        icons = {
          child_indent = '│',
          child_prefix = '├',
          collapsed = '─',
          expanded = '╮',
          failed = '󰚽',
          final_child_indent = ' ',
          final_child_prefix = '╰',
          non_collapsible = '─',
          notify = '',
          passed = '',
          running = '󱫭',
          running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
          skipped = '󰔞',
          unknown = '',
          watching = '',
        },
        adapters = {
          require 'neotest-jest' {
            -- jestCommand = "npm test --",
            -- jestConfigFile = "custom.jest.config.ts",
            -- env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          },
          require 'neotest-vstest',
          require 'neotest-golang' {
            runner = 'gotestsum',
          },
        },
        -- status = { virtual_text = true },
        -- output = { open_on_run = true },
        quickfix = {
          enabled = true,
          open = function()
            require('trouble').open { mode = 'quickfix', focus = true }
          end,
        },
      }

      local map = vim.keymap.set
      map('n', '<leader>tt', require('neotest').run.run, { desc = 'Test file' })
      map('n', '<leader>td', function()
        require('neotest').run.run { strategy = 'dap' }
      end, { desc = 'Debug test' })
      map('n', '<leader>ta', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = 'Run all test file' })
      map('n', '<leader>ts', require('neotest').summary.toggle, { desc = 'Summary test' })
      map('n', '<leader>tp', require('neotest').output.open, { desc = 'Preview test' })
      map('n', '<leader>tP', require('neotest').output_panel.toggle, { desc = 'Preview all test' })
      map('n', '[t', require('neotest').jump.prev, { desc = 'Jump prev test' })
      map('n', ']t', require('neotest').jump.next, { desc = 'Jump next test' })
    end,
  },
}
