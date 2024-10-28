vim.opt.background = "dark" -- set this to dark or light

require("core.options")
require("core.keymaps")
require("core.snippets") -- Custom code snippets

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"nyoom-engineering/oxocarbon.nvim",
	require("plugins.alpha"),
	require("plugins.none-ls"), -- Adjusted to remove special characters; ensure the file name is correct.
	require("plugins.neotree"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.lsp"), -- Corrected from "Isp" to "lsp"
	require("plugins.telescope"),
	require("plugins.autocompletion"),
	require("plugins.comment"),
	require("plugins.gitsigns"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
})

vim.cmd("colorscheme oxocarbon")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
