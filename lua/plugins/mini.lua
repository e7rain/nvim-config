local PickBuffers = function(opts)
  local wipeout_cur = function()
    vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
  end
  local buffer_mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } }
  MiniPick.builtin.buffers(local_opts, { mappings = buffer_mappings })
  MiniPick.refresh()
end

return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  ---@format disable-next
  keys = {
    -- stylua: ignore start
    { "<leader><leader>", PickBuffers, desc = "Buffers" },
    { "<leader>fg", '<Cmd>Pick grep_live<cr>', desc = "Grep" },
    { "<leader>fw", '<Cmd>Pick grep pattern="<cword>"<CR>', desc = "Grep [word]" },
    { "<leader>ff", '<Cmd>Pick files<cr>', desc = "Find Files" },
    { "<leader>fh", '<Cmd>Pick git_hunks path="%"<CR>', desc = "Modified hunks (buf)" },
    -- stylua: ignore end
  },
  config = function()
    vim.keymap.set('n', '-', function()
      local MiniFiles = require 'mini.files'
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      MiniFiles.open(path)
      MiniFiles.reveal_cwd()
    end, { desc = 'open directory' })

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

      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

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

    require('mini.extra').setup {}
    require('mini.bufremove').setup {}
    require('mini.pick').setup {}
    require('mini.splitjoin').setup {}
    local ext3_blocklist = { scm = true, txt = true, yml = true }
    local ext4_blocklist = { json = true, yaml = true }
    require('mini.icons').setup {
      use_file_extension = function(ext, _)
        return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
      end,
    }

    vim.ui.select = MiniPick.ui_select

    require('mini.files').setup {
      mappings = {
        go_in = 'l',
        go_in_plus = '<CR>',
        go_out = '',
        go_out_plus = 'h',
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

    require('mini.ai').setup {
      n_lines = 500,
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup {
      use_icons = true,
    }

    -- vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { link = 'StatusLine' }) -- Fix color issue koda theme

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
