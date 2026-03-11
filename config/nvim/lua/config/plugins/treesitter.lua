return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local lang = vim.bo[args.buf].filetype
					if lang ~= "" and pcall(vim.treesitter.get_parser, args.buf, lang) then
						vim.treesitter.start(args.buf)
					end
				end,
			})
		end
	}
}
