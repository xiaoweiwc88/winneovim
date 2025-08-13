return {
	{
		"ellisonleao/glow.nvim", -- 核心预览插件
		ft = "markdown",
		config = true,
		keys = {
			{ "<leader>md", "<cmd>Glow<CR>", desc = "Markdown Preview" },
		},
	},
	{
		"iamcco/markdown-preview.nvim", -- 备选浏览器预览
		build = "cd app && npm install",
		ft = "markdown",
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Browser Preview" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter", -- 语法增强
		opts = {
			highlight = { enable = true },
			markdown = { enable = true },
		},
	},
	{
		"dhruvasagar/vim-table-mode", -- 表格工具
		ft = "markdown",
		config = function()
			vim.g.table_mode_corner = "|"
		end,
	},
}
