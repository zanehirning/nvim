return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup{
            open_mapping = [[<c-\>]],
            direction = 'float',
            shell = vim.o.shell,
            auto_scroll = true,
            start_in_insert = true,
            float_opts = {
                border = 'curved',
                winblend = 0,
                highlights = {
                    border = 'Normal',
                    background = 'Normal'
                }
            }
        }
    end
}
