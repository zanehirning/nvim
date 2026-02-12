return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "luvit-meta/library",      words = { "vim%.uv" } },
                        { path = "/usr/share/awesome/lib/", words = { "awesome" } },
                    },
                },
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- Don't do LSP stuff if we're in Obsidian Edit mode
            local capabilities = nil
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            end

            local servers = {
                lua_ls = {
                    cmd = { "lua-language-server" },
                },
                clangd = {},
            }

            local servers_to_install = vim.tbl_filter(function(key)
                local t = servers[key]
                if type(t) == "table" then
                    return not t.manual_install
                else
                    return t
                end
            end, vim.tbl_keys(servers))

            require("mason").setup()
            local ensure_installed = {
                "stylua",
                "lua_ls",
                "clangd"
            }

            vim.list_extend(ensure_installed, servers_to_install)
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            -- Set global capabilities for all LSP servers
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false
            })

            -- Configure and enable each LSP server
            for name, config in pairs(servers) do
                if config == true then
                    config = {}
                end

                -- Only call vim.lsp.config if there are server-specific settings
                if next(config) ~= nil then
                    -- Remove manual_install flag as it's not an LSP config field
                    local lsp_config = vim.tbl_deep_extend("force", {}, config)
                    lsp_config.manual_install = nil
                    vim.lsp.config(name, lsp_config)
                end

                vim.lsp.enable(name)
            end
        end,
    },
}
