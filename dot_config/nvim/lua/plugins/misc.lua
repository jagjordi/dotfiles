return {
  {
    -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- require("mini.surround").setup()

      -- Simple and easy statusline.
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()
      -- Document existing key chains
      require("which-key").add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>h_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true }
      })
    end,
  },

  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  {"numToStr/Comment.nvim", lazy = false },
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    init = function()
      vim.keymap.set(
      'x',
      'ad',
      function()
        require'align'.align_to_char({
          preview = true,
          length = 2,
        })
      end,
      NS
      )

      -- Aligns to a string with previews
      vim.keymap.set(
      'x',
      'aw',
      function()
        require'align'.align_to_string({
          preview = true,
          regex = false,
        })
      end,
      NS
      )

      -- Aligns to a Vim regex with previews
      vim.keymap.set(
      'x',
      'ar',
      function()
        require'align'.align_to_string({
          preview = true,
          regex = true,
        })
      end,
      NS
      )

      -- Example gawip to align a paragraph to a string with previews
      vim.keymap.set(
      'n',
      'gaw',
      function()
        local a = require'align'
        a.operator(
        a.align_to_string,
        {
          regex = false,
          preview = true,
        }
        )
      end,
      NS
      )

      -- Example gaaip to align a paragraph to 1 character
      vim.keymap.set(
      'n',
      'gaa',
      function()
        local a = require'align'
        a.operator(a.align_to_char)
      end,
      NS
      )     -- Create your mappings here
    end
  }
}
