return {
  "folke/sidekick.nvim",
  version = "*", -- Use the latest release
  cmd = "Sidekick",
  opts = {
    -- Configuration options (defaults are usually sufficient)
    cli = {
      command = "gemini",
      win = { layout = "right" }, -- "float", "left", "bottom", "top", "right"
      mux = {
        enabled = true,
        backend = "tmux",
      },
    },
  },
  keys = {
    { "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "Toggle AI CLI" },
    { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select AI Tool" },
    { "<leader>ap", function() require("sidekick.cli").prompt() end, desc = "AI Prompts" },
    {
      "<tab>",
      function()
        -- Jump to or apply the Next Edit Suggestion if available
        if not require("sidekick").nes_jump_or_apply() then
          -- Return nil or fallback if no suggestion to allow standard Tab behavior
          return "<Tab>"
        end
        return ""
      end,
      expr = true,
      desc = "Next Edit Suggestion",
    },
  },
}
