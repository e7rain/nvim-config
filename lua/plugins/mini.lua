return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    vim.keymap.set('n', '-', function()
      local MiniFiles = require 'mini.files'
      if not MiniFiles.close() then
        local buf_name = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
        MiniFiles.open(path)
      end

      MiniFiles.reveal_cwd()
    end, { desc = 'open directory' })

    -- Mini files
    local files = require 'mini.files'
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = files.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        files.set_target_window(new_target)
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'MiniFilesWindowOpen',
    --   callback = function(args)
    --     local win_id = args.data.win_id
    --
    --     -- Customize window-local settings
    --     -- vim.wo[win_id].winblend = 10
    --     local config = vim.api.nvim_win_get_config(win_id)
    --     -- config.border = 'solid'
    --     vim.api.nvim_win_set_config(win_id, config)
    --   end,
    -- })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        map_split(buf_id, '<c-v>', 'belowright vertical')
        map_split(buf_id, '<c-s>', 'belowright horizontal')
        vim.keymap.set('n', '<esc>', files.close, { buffer = buf_id, desc = 'Close explorer' })
        vim.keymap.set('i', '<C-h>', '<Left>', { buffer = buf_id })
        vim.keymap.set('i', '<C-j>', '<Down>', { buffer = buf_id })
        vim.keymap.set('i', '<C-k>', '<Up>', { buffer = buf_id })
        vim.keymap.set('i', '<C-l>', '<Right>', { buffer = buf_id })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })

    -- require('mini.pick').setup {}
    require('mini.splitjoin').setup {}
    require('mini.icons').setup {}
    require('mini.files').setup {

      -- Customization of shown content
      content = {
        -- Predicate for which file system entries to show
        filter = nil,
        -- What prefix to show to the left of file system entry
        prefix = nil,
        -- In which order to show file system entries
        sort = nil,
      },

      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = 'q',
        go_in = 'l',
        go_in_plus = '<CR>',
        go_out = '',
        go_out_plus = 'h',
        mark_goto = "'",
        mark_set = 'm',
        reset = '~',
        reveal_cwd = '_',
        show_help = 'g?',
        synchronize = '=',
        trim_left = '<',
        trim_right = '>',
      },

      -- General options
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = true,
        -- Whether to use for editing directories
        use_as_default_explorer = true,
      },

      -- Customization of explorer windows
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = false,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 25,
      },
    }

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    --

    require('mini.ai').setup {
      n_lines = 500,
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
    }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
