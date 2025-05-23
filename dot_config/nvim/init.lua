-- NVIM configuration file

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true 

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignorecase = true
vim.opt.wildoptions = "fuzzy"

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- vim.keymap.set("t", "<C-E>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Faster window movements
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Toggles
vim.keymap.set("n", "<leader>tf", ":Neotree focus<CR>", { desc = "Open file tree" })
vim.keymap.set("n", "<leader>tF", ":Neotree show<CR>", { desc = "Show file tree" })
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle [T]erminal" })
vim.keymap.set("n", "<leader>tc", ":CopilotChatToggle<CR>", { desc = "Toggle [C]opilot" })

-- vim.keymap.set("n", "<leader>gg", ":TermExec cmd=\"lazygit\" direction=float<CR>", { desc = "Open [G]it in a floating terminal" })

vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float"})
local ranger = Terminal:new({ cmd = "ranger", hidden = true, direction = "float"})

function _lazygit_toggle()
    lazygit:toggle()
end

function _ranger_toggle()
    ranger:toggle()
end

vim.keymap.set("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true, desc = "Open [G]it"})
vim.keymap.set("n", "<leader>tr", "<cmd>lua _ranger_toggle()<CR>", {noremap = true, silent = true, desc = "Open [R]anger"})
