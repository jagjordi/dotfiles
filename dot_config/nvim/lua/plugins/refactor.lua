return {  
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
  },
  {
  'viocost/viedit',
  config = function()
    require('viedit').setup()
    -- bind to <leader> asterisk
    vim.api.nvim_set_keymap('n', '<leader>*', '<cmd>lua require("viedit").toggle_all()<CR>', { desc='iedit' })
  end
}
}
