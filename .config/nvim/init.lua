require("rxbn.util.globals")
require("rxbn.options")
require("rxbn.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  ui = {
    backdrop = 100,
  },
})

return {
  -- Install fzf
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end, -- Ensures fzf is installed
  },
  {
    "junegunn/fzf.vim", -- fzf.vim for Vim commands like :Files
  },
}
