return {
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
    tag = "0.1.5",
    config = function ()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>' )
    end
}
