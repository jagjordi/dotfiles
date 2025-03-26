-- coc.nvim
-- lazy.nvim 
return {
  { 
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
    end,
  },
}
