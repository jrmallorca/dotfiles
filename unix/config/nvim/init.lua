local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

for _, source in ipairs({
	-- CORE
	"core.plugins",
	"core.opts",
	"core.maps",
	"core.colors",

	-- PLUGS
	"plugins.telescope",
	"plugins.gitsigns",
	"plugins.true-zen",
	"plugins.lspconfig",
	"plugins.nvim-cmp",
	"plugins.nvim-autopairs",
	"plugins.commented",
	"plugins.nvim-treesitter",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end
