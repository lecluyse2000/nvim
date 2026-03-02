local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "number"

-- Temporary setting until I finally get tmux setup
vim.cmd([[
   augroup TerminalSettings
      autocmd!
      autocmd TermOpen * startinsert
      autocmd TermOpen * setlocal signcolumn=no
      autocmd TermOpen * setlocal nonumber norelativenumber
   augroup END
]])
opt.scrolloff = 8
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard = 'unnamedplus'
opt.modifiable = true
opt.guicursor = ""
