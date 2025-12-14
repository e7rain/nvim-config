return {
  chat = {
    completion_provider = 'blink',
    tools = {
      opts = {
        -- default_tools = {
        --   'full_stack_dev',
        -- },
      },
    },
    slash_commands = {
      ['buffer'] = {
        opts = {
          provider = 'snacks',
        },
      },
      ['file'] = {
        opts = {
          provider = 'snacks',
          contains_code = true,
        },
      },
    },
    -- variables = {
    --   ['buffer'] = {
    --     opts = {
    --       default_params = 'watch',
    --     },
    --   },
    -- },
    adapter = 'copilot',
    keymaps = {
      close = {
        modes = {
          n = 'q',
        },
        index = 4,
        callback = 'keymaps.close',
        description = 'Close Chat',
      },
      stop = {
        modes = {
          n = '<C-c>',
        },
        index = 5,
        callback = 'keymaps.stop',
        description = 'Stop Request',
      },
    },
  },
  inline = {
    adapter = 'copilot',
    keymaps = {
      accept_change = {
        modes = { n = 'ga' },
        description = 'Accept the suggested change',
      },
      reject_change = {
        modes = { n = 'gr' },
        opts = { nowait = true },
        description = 'Reject the suggested change',
      },
    },
  },
  cmd = {
    adapter = 'deepseek',
  },
}
