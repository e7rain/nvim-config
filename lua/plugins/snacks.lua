---@diagnostic disable: undefined-global
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    styles = {
      notification = {
        border = 'single',
      },
      notification_history = {
        border = 'solid',
        width = 0.9,
        height = 0.8,
      },
      scratch = {
        border = 'solid',
      },
    },
    bigfile = {
      enabled = true,
      notify = true, -- show notification when big file detected
      size = 1.5 * 1024 * 1024, -- 1.5MB
      line_length = 1000, -- average line length (useful for minified files)
      -- Enable or disable features when big file detected
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        vim.api.nvim_create_autocmd({ 'LspAttach' }, {
          buffer = buf,
          callback = function(args)
            vim.schedule(function()
              vim.lsp.buf_detach_client(buf, args.data.client_id)
            end)
          end,
        })

        if vim.fn.exists ':NoMatchParen' ~= 0 then
          vim.cmd [[NoMatchParen]]
        end
        Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
        vim.b.minianimate_disable = true
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            vim.bo[ctx.buf].syntax = ctx.ft
          end
        end)

        -- Disable supermaven suggestions with delay
        local function setup_after_plugin()
          if pcall(require, 'plugin-name') then
            vim.cmd 'SupermavenStop'
          else
            vim.defer_fn(setup_after_plugin, 500)
          end
        end
      end,
    },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    toggle = {
      enabled = true,
    },
    quickfile = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    scope = { enabled = true },
    win = {
      enabled = true,
    },
  },
  ---@format disable-next
  keys = {
    {
      '<leader>n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>gG',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'Lazygit open',
    },
    {
      '<leader>c',
      function()
        Snacks.bufdelete.delete()
      end,
      desc = 'Close buffer',
    },
    {
      '<leader>C',
      function()
        Snacks.bufdelete.all()
      end,
      desc = 'Close all buffers',
    },
    {
      '<c-space>',
      function()
        Snacks.terminal.toggle()
      end,
      mode = { 'n', 't' },
      desc = 'Toggle Terminal',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        -- Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
        Snacks.toggle.zoom():map '<leader>uZ'
        Snacks.toggle.zen():map '<leader>uz'
        Snacks.toggle({
          name = 'Diffview',
          get = function()
            return require('diffview.lib').get_current_view() ~= nil
          end,
          set = function(state)
            vim.cmd('Diffview' .. (state and 'Open' or 'Close'))
          end,
        }):map '<leader>G'
        Snacks.toggle({
          name = 'Suggestions AI',
          get = function()
            return require('supermaven-nvim.api').is_running()
          end,
          set = function(state)
            vim.cmd('Supermaven' .. (state and 'Start' or 'Stop'))
          end,
        }):map '<leader>ua'

        Snacks.toggle({
          name = 'Autoformat',
          get = function()
            return vim.g.disable_autoformat == false
          end,
          set = function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end,
        }):map '<leader>uf'

        -- Nvim Dap View
        Snacks.toggle({
          name = ' Debug view toggle',
          get = function()
            return false
          end,
          set = function()
            vim.cmd 'DapViewToggle'
          end,
        }):map '<leader>ud'
      end,
    })
  end,
}
