return {
	"christoomey/vim-tmux-navigator",
	-- cmd = {
	-- 	"TmuxNavigateLeft",
	-- 	"TmuxNavigateDown",
	-- 	"TmuxNavigateUp",
	-- 	"TmuxNavigateRight",
	-- 	"TmuxNavigatePrevious",
	-- 	"TmuxNavigatorProcessList",
	-- },
	-- keys = {
	-- 	{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
	-- 	{ "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
	-- 	{ "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
	-- 	{ "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
	-- 	{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
	-- },
	keys = {
		{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" }, desc = "Tmux Left" },
		{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" }, desc = "Tmux Down" },
		{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" }, desc = "Tmux Up" },
		{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" }, desc = "Tmux Right" },
		{ "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "t" }, desc = "Tmux Previous" },
	},
}
