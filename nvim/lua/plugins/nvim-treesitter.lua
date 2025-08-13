return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    branch = "master", -- 详见本系列的附录
    event = "VeryLazy",
    opts = {
        ensure_installed = { "lua", "go", "c", "markdown", "markdown_inline" },
        highlight = { enable = true },
        indent = { enable = true },            -- 启用基于语法的缩进
        incremental_selection = { enable = true }, -- 启用增量选择
    },
}
