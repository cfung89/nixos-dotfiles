vim.api.nvim_create_user_command("W", function() vim.cmd("w") end, { desc = "Save file", })
vim.api.nvim_create_user_command("Wq", function() vim.cmd("wq") end, { desc = "Save and quit file", })
vim.api.nvim_create_user_command("Q", function() vim.cmd("q") end, { desc = "Save file", })

-- Prevent Command history window from popping up
vim.api.nvim_create_autocmd("CmdwinEnter", {
    group = vim.api.nvim_create_augroup("NoCmdWin", { clear = true }),
    callback = function()
        local type = vim.fn.getcmdwintype()
        vim.cmd.close()
        vim.fn.feedkeys(type, "n")
    end,
})
