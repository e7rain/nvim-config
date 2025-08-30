return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G', 'Gvdiffsplit', 'Gedit' },
  keys = {
    {
      '<leader>gg',
      '<cmd>Git<cr>',
      desc = 'Git',
    },
  },
}
