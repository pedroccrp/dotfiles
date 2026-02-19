-- Utility plugins: which-key, undotree, tmux
-- All these load on both local and server
return {
  -- Which-key
  {
    "folke/which-key.nvim",
    config = function()
      local which_key = require("which-key")
      which_key.setup({ delay = 800 })
    end,
  },

  -- Undotree
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true })
    end,
  },

  -- Indent blankline (already in core as ibl, but keeping for reference)
  -- "lukas-reineke/indent-blankline.nvim",

  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Tmux navigation
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      nvim_tmux_nav.setup {}
      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
    end,
  },
}
