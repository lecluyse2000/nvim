local config = function()
   require("nvim-treesitter").setup({
      indent = {
         enable = true,
      },
      ensure_installed = {
         "lua",
         "json",
         "javascript",
         "typescript",
         "haskell",
         "html",
         "css",
         "cmake",
         "c",
         "cpp",
         "bash",
         "lua",
         "gitignore",
         "python",
      },
      auto_install = true,
      highlight = {
         enable = true,
         additional_vim_regex_highlighting = { "markdown" },
      },
      incremental_selection = {
         enable = true,
         keymaps = {
            init_selection = "<C-s>",
            node_incremental = "<C-s>",
            scope_incremental = false,
            node_decremental = "<BS>",
         },
      },
   })
end

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = config,
}
