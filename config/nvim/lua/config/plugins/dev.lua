return {
	{
		dir = "~/Github/nvim_plugins/embrace.nvim",
		config = function()
			require("embrace").setup()
		end,
	},
	{
		dir = "~/Github/nvim_plugins/surf.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("surf").setup({
				default_engine = "DuckDuckGo",
				engines = {
					Elixir = { bang = "!ex", url = "https://hexdocs.pm/elixir/search.html?q=%s" },
					GoogleScholar = { bang = "!gs", url = "https://scholar.google.com/scholar?q=%s&hl=en" },
					Golang = { bang = "!go", url = "https://pkg.go.dev/search?limit=25&m=package&q=%s" },
				}
			})
		end,
	},
	{
		dir = "~/Github/nvim_plugins/cmdmacro.nvim",
		config = function()
			require("cmdmacro").setup({
				terminals = {
					Left = { width = function() return math.floor(0.2 * vim.o.columns) end},
					Right = { width = function() return math.floor(0.3 * vim.o.columns) end},
				},
				macros = {
					{
						name = "git_status",
						keymap = "<leader>gs",
						command = "git status"
					},
					{
						name = "git_add",
						keymap = "<leader>ga",
						command = "git add ."
					},
					{
						name = "git_diff",
						keymap = "<leader>gd",
						command = "git diff"
					},
					{
						name = "git_diff_staged",
						keymap = "<leader>gds",
						command = "git diff --staged"
					},
				},
				editor = { keymaps = { quit = { "q" } } }
			})
		end,
	},
	-- {
	-- 	dir = "~/Github/nvim_plugins/umple.nvim",
	-- 	config = function()
	-- 		require("umple").setup({})
	-- 	end,
	-- },
}
