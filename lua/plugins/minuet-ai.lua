return {
  'milanglacier/minuet-ai.nvim',
  config = function()
    require('minuet').setup {
      virtualtext = {
        auto_trigger_ft = {},
        keymap = {
          accept = '<C-]>',
        },
      },
      -- provider = 'gemini',
      provider = 'openai_fim_compatible',
      provider_options = {
        openai_fim_compatible = {
          api_key = 'DEEPSEEK_API_KEY',
          name = 'deepseek',
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
    }
  end,
}
