return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.asm = {
				install_info = {
					-- url = "https://github.com/cfung89/tree-sitter-armv7",
					url = "/home/cyrus/Github/tree-sitter-armv7",
					files = { "src/parser.c" },
				},
			}

			require("nvim-treesitter.configs").setup({
				ensure_installed = {},
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				indent = { enable = true },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
				modules = {},
			})
		end,
	},
}
