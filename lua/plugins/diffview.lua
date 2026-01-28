return {
  lazy = false,
  'sindrets/diffview.nvim',
  keys = {
    -- stylua: ignore
    { 'dv', function ()
      if next(require("diffview.lib").views) == nil then
        require("diffview").open()
      else
        require("diffview").close()
      end
    end, desc = '[D]iffview toggle', },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
    },
    hooks = {
      diff_buf_read = function(bufnr)
        vim.b[bufnr].view_activated = false
      end,
    },
    use_icons = true,
  },
}
