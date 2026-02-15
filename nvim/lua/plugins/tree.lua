return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>pv", "<cmd>Neotree filesystem reveal left toggle<CR>", desc = "Project tree" },
    },
    opts = {
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
    },
  },
}
