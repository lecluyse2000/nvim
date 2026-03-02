local keymap = vim.keymap

local config = function()
   local telescope = require("telescope")
   telescope.setup({
      defaults = {
         mappings = {
            i = {
               ["<C-j>"] = "move_selection_next",
               ["<C-k>"] = "move_selection_previous",
            },
         },
      },
      pickers = {
         find_files = {
            theme = "dropdown",
            previewer = true,
            hidden = true,
         },
         live_grep = {
            theme = "dropdown",
            previewer = true,
         },
         buffers = {
            theme = "dropdown",
            previewer = true,
         },
      },

      extensions = {
         file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            previewer = true,
         },
      },
   })
   local builtin = require('telescope.builtin')
   keymap.set("n", "<leader>fk", builtin.keymaps, {})
   keymap.set("n", "<leader>fh", builtin.help_tags, {})
   keymap.set("n", "<leader>ff", builtin.find_files, {})
   keymap.set("n", "<leader>fg", builtin.live_grep, {})
   keymap.set("n", "<leader>fb", builtin.buffers, {})
   keymap.set("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { noremap = true, silent = true })
   require("telescope").load_extension "file_browser"
end


return {
   "nvim-telescope/telescope.nvim", version = "*",
   lazy = false,
   dependencies = { "nvim-lua/plenary.nvim",
                  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
   },
   config = config,
}
