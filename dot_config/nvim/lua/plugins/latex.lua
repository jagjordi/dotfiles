return {
    "lervag/vimtex",
    config = function()
        -- vim.g.vimtex_view_method = "sioyek"
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 0
        -- let g:vimtex_grammar_textidote = {
        --     \ 'jar': '/usr/local/bin/textidote.jar',
        --     \ 'args': '--check en',
        --     \}
        --     g:vimtex_view_forward_search_on_start
        --     
        vim.g.vimtex_view_forward_search_on_start = 1
        vim.g.vimtex_grammar_textidote = {
            jar = "/usr/local/bin/textidote.jar",
            args = "--read-all"
        }
        vim.g.vimtex_compiler_latexmk = {
            options = {
                "-pdf",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-shell-escape",
            },
        }
    end
}
