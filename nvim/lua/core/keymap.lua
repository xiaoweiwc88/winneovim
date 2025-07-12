vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n","<leader>sv","<C-w>v") -- split window vertically
vim.keymap.set("n","<leader>sh","<C-w>s") -- split window vertically
vim.keymap.set("n","<leader>se","<C-w>=") -- split window vertically
vim.keymap.set("n","<leader>sx",":close<CR>") -- split window vertical


vim.keymap.set("n","<leader>to",":tabnew<CR>") -- open new tab
vim.keymap.set("n","<leader>tx",":tabclose<CR>") -- close current tab
vim.keymap.set("n","<leader>tn",":tabn<CR>") -- go to next tab keymap.set ("n"
vim.keymap.set("n","<leader>tp",":tabp<CR>") -- go to next tab keymap.set ("n"

-- vim.keymap.set("n","<leader>sm",":MaximizerToggle<CR>")
vim.keymap.set ("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set ("n", "<leader>fs", ":Telescope live_grep<CR>")
vim.keymap.set ("n", "<leader>fc", ":Telescop grep_string<CR>")
vim.keymap.set ("n", "<leader>fb", ":Telescope buffers<CR>")
vim.keymap.set ("n", "<leader>fh", ":Telescope help_tags<CR>")

vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', { desc = 'Locate current file in nvim-tree' })
