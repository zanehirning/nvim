require('toggleterm').setup{
	open_mapping = [[<c-\>]],
	direction = 'float',
	shell = vim.o.shell,
	auto_scroll = true, 
	float_opts = {
		border = 'curved',
		winblend = 0,
		highlights = {
			border = 'Normal',
			background = 'Normal'
		},
	},
}

