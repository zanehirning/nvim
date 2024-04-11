return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "python", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query" },
            sync_install = false,
            auto_install = true,
            indent = { enable = true },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })

        local treesitter_parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_configs.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            }
        }

        vim.treesitter.language.register("templ", "templ")
    end
}
