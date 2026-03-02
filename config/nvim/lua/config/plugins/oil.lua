return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,

		config = function()
			require("oil").setup({
				keymaps = {
					["<CR>"] = "actions.select",
					["<leader>g."] = { "actions.toggle_hidden", mode = "n" },
					["<leader>gr"] = "actions.refresh",
					["-"] = { "actions.parent", mode = "n" },
				},
				use_default_keymaps = false,
			})
		end
	}
}
