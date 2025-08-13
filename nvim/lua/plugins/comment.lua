-- return {
-- 	"numToStr/Comment.nvim",
-- 	event = "VeryLazy", -- 延迟加载
-- 	config = function()
-- 		require("Comment").setup({
-- 			-- 基础配置
-- 			padding = true, -- 在注释符号后添加空格
-- 			sticky = true, -- 保持光标在注释符号后
-- 			-- 快捷键配置
-- 			toggler = {
-- 				line = "gcc", -- 切换单行注释
-- 				block = "gbc", -- 切换块注释
-- 			},
-- 			-- 可视模式快捷键
-- 			opleader = {
-- 				line = "gc", -- 可视模式下用 `gc` 注释选中行
-- 				block = "gb", -- 可视模式下用 `gb` 注释选中块
-- 			},
-- 			-- 额外快捷键（如针对特定文本对象）
-- 			extra = {
-- 				above = "gcO", -- 在当前行上方添加注释
-- 				below = "gco", -- 在当前行下方添加注释
-- 				eol = "gcA", -- 在行尾添加注释
-- 			},
-- 			mappings = {
-- 				-- 禁用可视模式的额外映射（保留基础功能）
-- 				extra = false,
-- 			},
-- 		})
-- 	end,
-- }

return {
  'numToStr/Comment.nvim',
  opts = {
    toggler = { line = 'gcc', block = 'gbc' },
    opleader = { line = 'gc', block = 'gb' },
    post_hook = function(ctx)
      vim.schedule(function()
        if vim.fn.mode() == 'no' then
          vim.cmd('normal! \x1b')
        end
      end)
    end,
  },
  keys = {
    { 'gcc', mode = 'n', desc = 'Toggle line comment' },
    { 'gc', mode = 'v', desc = 'Comment selection' },
  },
}


