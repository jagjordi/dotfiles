return {
    "edluffy/hologram.nvim",
    config = function()
        -- hologram needs a terminal that reports its pixel size (kitty
        -- graphics protocol); skip setup quietly where it can't (e.g. WSL)
        pcall(function()
            require("hologram").setup{
                auto_display = false,
            }
        end)
    end
}
