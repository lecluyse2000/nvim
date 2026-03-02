local config = function()
   require("lualine").setup({
      options = {
         theme = "gruvbox-material",
         globalstatus = true,
         component_separators = { left = "|", right = "|" },
         section_separators = { left = "", right = "" },
      },
      sections = {
         lualine_a = { "mode" },
         lualine_b = { "buffers" },
         lualine_x = { "encoding", "fileformat", "filetype" },
         lualine_y = { "progress" },
         lualine_z = { "location" },
      },
      tabline = {},
   })
end

return {
   "nvim-lualine/lualine.nvim",
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   lazy = false,
   config = config,
}
