return {
  {
    "ja-ford/delaytrain.nvim",
    lazy = false,
    config = function()
      require("delaytrain").setup({
        keys = {
          ["nv"] = { "j", "k", "h", "l", "w", "b" },
          ["nvi"] = { "<Left>", "<Down>", "<Up>", "<Right>" },
        },
      })
    end,
  },
}
