return {




    -- { -- Autoformat
    --     "stevearc/conform.nvim",
    --     lazy = false,
    --     keys = {
    --         {
    --             "<leader>f",
    --             function()
    --                 require("conform").format({ async = true, lsp_fallback = true })
    --             end,
    --             mode = "",
    --             desc = "[F]ormat buffer",
    --         },
    --     },
    --     opts = {
    --         notify_on_error = false,
    --         format_on_save = function(bufnr)
    --             -- Disable "format_on_save lsp_fallback" for languages that don't
    --             -- have a well standardized coding style. You can add additional
    --             -- languages here or re-enable it for the disabled ones.
    --             local disable_filetypes = { c = true, cpp = true }
    --             return {
    --                 timeout_ms = 500,
    --                 lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --             }
    --         end,
    --         formatters_by_ft = {
    --             lua = { "stylua" },
    --             -- Conform can also run multiple formatters sequentially
    --             -- python = { "isort", "black" },
    --             --
    --             -- You can use a sub-list to tell conform to run *until* a formatter
    --             -- is found.
    --             -- javascript = { { "prettierd", "prettier" } },
    --         },
    --     },
    -- },


    -- { -- Highlight, edit, and navigate code
    --     "nvim-treesitter/nvim-treesitter",
    --     build = ":TSUpdate",
    --     opts = {
    --         ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
    --         auto_install = true,
    --         highlight = {
    --             enable = true,
    --             -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --             --  If you are experiencing weird indenting issues, add the language to
    --             --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    --             additional_vim_regex_highlighting = { "ruby" },
    --         },
    --         indent = { enable = true, disable = { "ruby" } },
    --     },
    --     config = function(_, opts)
    --         -- Prefer git instead of curl in order to improve connectivity in some environments
    --         require("nvim-treesitter.install").prefer_git = true
    --         ---@diagnostic disable-next-line: missing-fields
    --         require("nvim-treesitter.configs").setup(opts)
    --
    --         -- There are additional nvim-treesitter modules that you can use to interact
    --         -- with nvim-treesitter. You should go explore a few and see what interests you:
    --         --
    --         --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --         --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --         --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    --     end,
    -- },

}
