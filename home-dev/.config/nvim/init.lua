local o = vim.opt

-- line numbers
o.number = true
o.relativenumber = true

-- tabs & indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- line wrapping
o.wrap = false

-- search
o.ignorecase = true
o.smartcase = true

-- appearance
o.termguicolors = true
o.background = 'dark'

-- backspace
o.backspace = 'indent,eol,start'

-- clipboard
o.clipboard:append('unnamedplus')

-- split window
o.splitright = true
o.splitbelow = true
