-- return {
--     "nvim-telescope/telescope.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         {
--             "nvim-telescope/telescope-fzf-native.nvim",
--             build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
--                 .. "cmake --build build --config Release && "
--                 .. "cmake --install build --prefix build",
--         },
--     },
--     cmd = "Telescope",
--     opts = {
--         extensions = {
--             fzf = {
--                 fuzzy = true,
--                 override_generic_sorter = true,
--                 override_file_sorter = true,
--                 case_mode = "smart_case",
--             },
--         },
--     },
--     config = function(_, opts)
--         local telescope = require "telescope"
--         telescope.setup(opts)
--         telescope.load_extension("fzf")
--     end,
-- }

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && "
				.. "cmake --build build --config Release && "
				.. "cmake --install build --prefix build",
		},
	},
	cmd = "Telescope",
	keys = {
		-- 预填“当前光标单词”到 Live Grep（可继续编辑搜索词）
		{
			"<leader>fw",
			function()
				require("telescope.builtin").live_grep({
					default_text = vim.fn.expand("<cword>"),
					-- 字面量搜索，不解释正则；如需正则，去掉这行
					additional_args = function()
						return { "-F" }
					end,
				})
			end,
			desc = "Live Grep 当前光标单词",
		},
	},
	opts = function()
		-- ① 全局忽略规则（越早过滤，越省时）
		local ignore_globs = {
			".git/",
			"node_modules/",
			"dist/",
			"build/",
			"out/",
			"target/",
			"vendor/",
			".cache/",
			".venv/",
			".tox/",
			"Pods/",
			"DerivedData/",
			-- 典型大产物与锁文件
			"%.lock",
			"yarn%.lock",
			"package%-lock%.json",
			"%.min%.js",
			"%.min%.css",
			-- 二进制/大资源（正则按需增减）
			"%.png",
			"%.jpg",
			"%.jpeg",
			"%.webp",
			"%.gif",
			"%.pdf",
			"%.zip",
			"%.tar%.gz",
			"%.mp4",
			"%.mov",
			"%.mp3",
			"%.wav",
		}

		return {
			defaults = {
				-- ② 使用 ripgrep 做文本检索，参数尽量减少无用 IO
				vimgrep_arguments = (function()
					local args = {
						"rg",
						"--follow", -- 跟随符号链接（需要可关）
						"--hidden", -- 允许搜隐藏文件（配合下方 glob 排除）
						"--smart-case",
						"--trim", -- 去掉行首空白，加速排序/显示
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--max-columns=200", -- 超过则截断（避免极长行导致渲染卡）
						"--max-columns-preview",
						"--max-filesize",
						"1M", -- 跳过>1MB的大文件（按需调大/删掉）
					}
					-- 以 rg 的 --glob 提前排除整树目录，比事后过滤更快
					local globs = {
						"!.git/**",
						"!node_modules/**",
						"!dist/**",
						"!build/**",
						"!out/**",
						"!target/**",
						"!vendor/**",
						"!.cache/**",
						"!.venv/**",
						"!.tox/**",
						"!Pods/**",
						"!DerivedData/**",
					}
					for _, g in ipairs(globs) do
						table.insert(args, "--glob")
						table.insert(args, g)
					end
					return args
				end)(),
				file_ignore_patterns = ignore_globs,

				-- ③ UI 相关：尽量减少前端渲染开销
				path_display = { "truncate" }, -- 仅显示尾部，减少绘制/裁剪成本
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				layout_config = { prompt_position = "top" },
				color_devicons = false, -- 关图标可减少大量绘制（需要图标就开）

				-- ④ fzf-native 完全接管排序（你已装，这里确保生效）
				generic_sorter = require("telescope.sorters").get_fzy_sorter,
				file_sorter = require("telescope.sorters").get_fzy_sorter,

				history = {
					path = vim.fn.stdpath("state") .. "/telescope_history.sqlite3",
					limit = 1000,
				},
				mappings = {
					i = {
						["<Down>"] = require("telescope.actions").cycle_history_next,
						["<Up>"] = require("telescope.actions").cycle_history_prev,
					},
					n = {
						["<Down>"] = require("telescope.actions").cycle_history_next,
						["<Up>"] = require("telescope.actions").cycle_history_prev,
					},
				},
			},

			pickers = {
				-- 文件检索尽量用 fd（远快于 find）
				find_files = {
					-- 使用 fd：Mac 装 fd；Ubuntu 包名是 fd-find（可做别名 ln -s /usr/bin/fdfind ~/.local/bin/fd）
					find_command = {
						"fd",
						"--type",
						"f",
						"--hidden",
						"--strip-cwd-prefix",
						"--exclude",
						".git",
						"--exclude",
						"node_modules",
						"--exclude",
						"dist",
						"--exclude",
						"build",
						"--exclude",
						"out",
						"--exclude",
						"target",
						"--exclude",
						"vendor",
						"--exclude",
						".cache",
						"--exclude",
						".venv",
						"--exclude",
						".tox",
					},
					previewer = false, -- 关预览：列表/滚动会明显更顺滑
					no_ignore = false,
					follow = false,
				},
				-- 关键词检索：只对文本排序，避免把路径计入排序信号
				live_grep = {
					only_sort_text = true,
				},
				grep_string = {
					only_sort_text = true,
				},
				buffers = { sort_mru = true, ignore_current_buffer = true, previewer = false },
				oldfiles = { previewer = false },
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
}
