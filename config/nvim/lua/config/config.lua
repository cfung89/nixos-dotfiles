vim.api.nvim_create_user_command("W", function() vim.cmd("w") end, { desc = "Save file", })
vim.api.nvim_create_user_command("Wq", function() vim.cmd("wq") end, { desc = "Save and quit file", })
vim.api.nvim_create_user_command("Q", function() vim.cmd("q") end, { desc = "Save file", })

local trusted_paths = {
    vim.fn.expand("~/Code/achelous"),
}
local current_dir = vim.fn.getcwd()
for _, path in ipairs(trusted_paths) do
    if current_dir == path then
        vim.o.exrc = true
        break
    end
end
