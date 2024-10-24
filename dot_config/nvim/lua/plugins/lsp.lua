return{
    "neovim/nvim-lspconfig",
    dependencies = {
        "tamago324/nlsp-settings.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local lspconfutil = require("lspconfig.util")
        local configs = require("lspconfig.configs")
        local nlspsettings = require("nlspsettings")
        lspconfig.ltex.setup{}
        lspconfig.svlangserver.setup {}
        -- lspconfig.verible.setup {}

        -- lspconfig.veridian.setup {
        --     cmd = { "cargo", "run", "--manifest-path", "/home/jordi/Projects/veridian/Cargo.toml" }
        -- }
        --
        -- local veridian_root = lspconfutil.root_pattern("veridian.yml", ".git")
        -- lspconfig.veridian.setup {
        --   cmd = { "veridian" },
        --   root_dir = function(fname)
        --     local filename = lspconfutil.path.is_absolute(fname) and fname
        --     or lspconfutil.path.join(vim.loop.cwd(), fname)
        --     return veridian_root(filename) or lspconfutil.path.dirname(filename)
        -- end;
        -- }
        -- vim.tbl_deep_extend('keep', lspconfig, {
        --     svlsp = {
        --         cmd = { "/home/jordi/Projects/svlsp/target/debug/svlsp"},
        --         filetypes = { "systemverilog" },
        --         root_dir = lspconfutil.root_pattern("svlsp.toml", ".git"),
        --     },
        -- })
        --
        -- configs.svlsp = {
        --     default_config = {
        --         cmd = { "/home/jordi/Projects/svlsp/target/debug/svlsp"},
        --         filetypes = { "systemverilog" },
        --         root_dir = lspconfutil.root_pattern("svlsp.toml", ".git"),
        --     },
        -- }
        --
        -- lspconfig.svlsp.setup {}
        --
        -- lspconfig.pyright.setup {}
        -- lspconfig.ltex.setup {
        --     settings = {
        --         ltex = {
        --             language = "en-GB",
        --         }
        --     }
        -- }

        -- nlspsettings.setup {}

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = "Go to [D]efinitionnnnn"})
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
            end,
        })
    end
}
