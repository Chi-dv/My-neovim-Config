vim.opt.background = "dark" -- set this to dark or light

require 'core.options'
require 'core.keymaps'

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
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  require 'plugins.neotree',
  require 'plugins.bufferline', 
  require 'plugins.lualine',
  require 'plugins.treesitter'
})

vim.cmd("colorscheme oxocarbon")

