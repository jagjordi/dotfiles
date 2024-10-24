return {
    {
        "folke/tokyonight.nvim",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        -- init = function()
        --     vim.cmd.colorscheme("tokyonight-day")
        --     vim.cmd.hi("Comment gui=none")
        -- end,
    },

    {
        "maxmx03/solarized.nvim",
        lazy = false,
    },
    {
        "catppuccin/nvim",
        init = function()
            vim.cmd("colorscheme catppuccin-latte")
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    }
}
