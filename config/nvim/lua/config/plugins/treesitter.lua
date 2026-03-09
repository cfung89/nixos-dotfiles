return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { '<filetype>' },
				callback = function() vim.treesitter.start() end,
			})
			require("nvim-treesitter").setup({
				ensure_installed = {},
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				indent = { enable = true },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
			})
		end
	}
}
