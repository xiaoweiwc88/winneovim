return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		actions = {
			open_file = {
				quit_on_open = false,
			},
			change_dir = {
				enable = true,
				global = true, -- 全局更改目录
			},
		},
		renderer = {
			icons = {
				glyphs = {
					folder = {
						arrow_closed = "", -- arrow when folder is closed

						arrow_open = "", -- arrow when folder is open
					},
				},
			},
		},
		sync_root_with_cwd = true, -- 根目录变化时更新 Neovim 的 cwd
		respect_buf_cwd = true, -- 尊重缓冲区的 cwd
		update_focused_file = {
			enable = true,
			update_root = true, -- 聚焦文件时可能更新根目录
		},
	},
	keys = {
		{ "<leader>e", ":NvimTreeToggle<CR>" },
	},
	vim.keymap.set("n", "<leader>r", function()
		require("nvim-tree.api").tree.change_root_to_node()
	end, { desc = "Set directory as root in nvim-tree" }),
	config = function(_, opts)
		require("nvim-tree").setup(opts)
		vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
	end,
}
