vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		if vim.v.hlsearch == 0 then
			return
		end
		local keycode = vim.api.nvim_replace_termcodes('<Cmd>nohl<CR>', true, false, true)
		vim.api.nvim_feedkeys(keycode, 'n', false)
	end,
})
