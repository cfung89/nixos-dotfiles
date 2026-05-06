return {
	{
		dir = "~/Code/nvim_plugins/embrace.nvim",
		config = function()
			require("embrace").setup()
		end,
	},
	{
		dir = "~/Code/nvim_plugins/cmdmacro.nvim",
		config = function()
			require("cmdmacro").setup({
				default_terminal = "Bottom",
				terminals = {
					Left = { width = function() return math.floor(0.2 * vim.o.columns) end },
					Right = { width = function() return math.floor(0.5 * vim.o.columns) end },
					Bottom = { height = function() return math.floor(0.4 * vim.o.lines) end },
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
						command = "git diff",
						interactive = true
					},
					{
						name = "git_diff_staged",
						keymap = "<leader>gds",
						command = "git diff --staged",
						interactive = true
					},
					{
						name = "git_commit",
						keymap = "<leader>gc",
						command = "git commit -m \"",
						interactive = true
					},
				},
				-- editor = { keymaps = { quit = { "q" } } }
			})
		end,
	},
	{
		dir = "~/Code/nvim_plugins/vibes.nvim",
		config = function()
			require("vibes").setup({
				api = {
					key = vim.fn.stdpath("config") .. "/lua/config/plugins/.env"
				}
			})
		end,
	},
	-- {
	-- 	dir = "~/Code/nvim_plugins/surf.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	config = function()
	-- 		require("surf").setup({
	-- 			default_engine = "DuckDuckGo",
	-- 			engines = {
	-- 				Elixir = { bang = "!ex", url = "https://hexdocs.pm/elixir/search.html?q=%s" },
	-- 				GoogleScholar = { bang = "!gs", url = "https://scholar.google.com/scholar?q=%s&hl=en" },
	-- 				Golang = { bang = "!go", url = "https://pkg.go.dev/search?limit=25&m=package&q=%s" },
	-- 			}
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	dir = "~/Code/nvim_plugins/umple.nvim",
	-- 	config = function()
	-- 		require("umple").setup({})
	-- 	end,
	-- },
}
