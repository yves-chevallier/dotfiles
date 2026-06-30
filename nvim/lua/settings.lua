-- Editor options — ported from ~/.vimrc (kept as the vim fallback).
local opt = vim.opt

-- Presentation
opt.number = true
opt.numberwidth = 4
opt.termguicolors = true
opt.cursorline = true
opt.showmatch = true
opt.linebreak = true
opt.wrap = false
opt.scrolloff = 8
opt.colorcolumn = '80'
opt.title = true
opt.laststatus = 2
opt.fillchars:append({ vert = '│' })

-- Indentation / tabs
opt.tabstop = 4
opt.shiftwidth = 0          -- follow tabstop
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.textwidth = 100

-- Editing behaviour
opt.virtualedit = 'all'
opt.backspace = { 'eol', 'start', 'indent' }
opt.nrformats:remove('octal')
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
-- Use ripgrep for :grep when available
if vim.fn.executable('rg') == 1 then
  opt.grepprg = 'rg --vimgrep --smart-case --follow'
  opt.grepformat = '%f:%l:%c:%m'
end

-- Files / buffers / history
opt.hidden = true
opt.autoread = true
opt.swapfile = false
opt.undofile = true         -- persistent undo (replaces undolevels tuning)
opt.history = 1000
opt.fileformats = { 'unix', 'dos' }
opt.wildignore:append({ '*.o', '*~', '*.pyc', '*.doj', '*.exe' })
opt.wildmenu = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance / responsiveness
opt.ttimeoutlen = 0
opt.timeoutlen = 300
opt.lazyredraw = false      -- off: can glitch with modern UI plugins
