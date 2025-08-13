-- lazy.nvim
return {
  {
    "djoshea/vim-autoread",
    init = function()
      -- 开启自动读盘 & 提升检查频率
      vim.o.autoread = true
      vim.o.updatetime = 500
      -- 可选：重载后提示
      vim.api.nvim_create_autocmd("FileChangedShellPost", {
        callback = function()
          vim.notify("File changed on disk → buffer reloaded", vim.log.levels.WARN)
        end,
      })
    end,
  },
}

