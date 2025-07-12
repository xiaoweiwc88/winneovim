return {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason-lspconfig.nvim",
    },
    -- lazy = false,
    opts = {},
    config = function(_, opts)
        require("mason").setup(opts)
        local registry = require "mason-registry"
           -- 设置 mason-lspconfig
        require("mason-lspconfig").setup({
            automatic_installation = true,
        })

        local function setup(name, config)
            local success, package = pcall(registry.get_package, name)
            if success and not package:is_installed() then
                package:install()
            end

            local lsp_mappings = {
                ["lua-language-server"] = "lua_ls",          -- Lua
                ["gopls"] = "gopls",                        -- Golang
                -- ["clangd"] = "clangd",                      -- C/C++
                -- ["pyright"] = "pyright",                    -- Python
                -- ["rust-analyzer"] = "rust_analyzer",        -- Rust
                -- 可以继续添加其他语言...
            }
            local lsp_name = lsp_mappings[name]
            if not lsp_name then
                vim.notify("Unsupported LSP: " .. name, vim.log.levels.WARN)
                return
            end
            config.capabilities = require("blink.cmp").get_lsp_capabilities() -- 新添加的内容
            config.on_attach = function (client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end
            require("lspconfig")[lsp_name].setup(config)

        end

        local servers = {
            ["lua-language-server"] = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    }
                }
            },
            ["gopls"] = {
            },
        }
        for server, config in pairs(servers) do
            setup(server, config)
        end

        vim.diagnostic.config({
            virtual_text = true,
            update_insert_mode = true,
        })
    end,
}
