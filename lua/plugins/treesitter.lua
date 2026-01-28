local languages = {
  'bash',
  'bicep',
  'c',
  'c_sharp',
  'css',
  'cmake',
  'diff',
  'dockerfile',
  'dockerfile',
  'git_config',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'graphql',
  'html',
  'http',
  'hurl',
  'javascript',
  'json',
  'json5',
  -- 'jsonc',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'rust',
  'sql',
  'ssh_config',
  'terraform',
  'tmux',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    -- config = function()
    --   -- replicate `ensure_installed`, runs asynchronously, skips existing languages
    --   require('nvim-treesitter').install(languages)
    --
    --   vim.api.nvim_create_autocmd('FileType', {
    --     group = vim.api.nvim_create_augroup('treesitter.setup', {}),
    --     callback = function(args)
    --       local buf = args.buf
    --       local filetype = args.match
    --
    --       -- you need some mechanism to avoid running on buffers that do not
    --       -- correspond to a language (like oil.nvim buffers), this implementation
    --       -- checks if a parser exists for the current language
    --       local language = vim.treesitter.language.get_lang(filetype) or filetype
    --       if not vim.treesitter.language.add(language) then
    --         return
    --       end
    --
    --       -- replicate `fold = { enable = true }`
    --       vim.wo.foldmethod = 'expr'
    --       vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    --
    --       -- replicate `highlight = { enable = true }`
    --       vim.treesitter.start(buf, language)
    --
    --       -- replicate `indent = { enable = true }`
    --       vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --
    --       -- `incremental_selection = { enable = true }` cannot be easily replicated
    --     end,
    --   })
    -- end,
  },
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      ensure_installed = languages,
      fold = { enable = true },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<cr>',
          node_incremental = '<cr>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
  },
}
