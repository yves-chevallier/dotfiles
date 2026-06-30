-- Key mappings — ported/adapted from ~/.vimrc.
-- Leader is <Space> (set in init.lua); the old vim config used ",".
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Plugin shortcuts -----------------------------------------------------------
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)   -- old: F1 / NERDTree
map('n', '<F1>',      ':NvimTreeToggle<CR>', opts)
map('n', '<leader>s', ':SymbolsOutline<CR>', opts)   -- old: F4 / Tagbar
map('n', '<F4>',      ':SymbolsOutline<CR>', opts)
map('n', '<leader>t', ':ToggleTerm<CR>', opts)

-- Telescope (old: CtrlP / Grepper) ------------------------------------------
map('n', '<C-p>',      ':Telescope find_files<CR>', opts)
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)
map('n', '<leader>*',  ':Telescope grep_string<CR>', opts)  -- search word under cursor

-- Editor behaviour from the old vimrc ---------------------------------------
-- jj leaves insert mode
map('i', 'jj', '<Esc>', opts)

-- Move by visual lines on wrapped lines
map({ 'n', 'v' }, 'j', 'gj', opts)
map({ 'n', 'v' }, 'k', 'gk', opts)

-- Q reformats paragraph / selection
map('n', 'Q', 'gqap', opts)
map('v', 'Q', 'gq', opts)

-- Ctrl-S saves (like every modern editor)
map('n', '<C-s>', ':update<CR>', opts)
map('i', '<C-s>', '<C-o>:update<CR>', opts)
map('v', '<C-s>', '<C-c>:update<CR>', opts)

-- Ctrl-A select all
map('n', '<C-a>', 'ggVG', opts)

-- Bubble the current line / selection up and down
map('n', '<C-Down>', ':m .+1<CR>==', opts)
map('n', '<C-Up>',   ':m .-2<CR>==', opts)
map('v', '<C-Down>', ":m '>+1<CR>gv=gv", opts)
map('v', '<C-Up>',   ":m '<-2<CR>gv=gv", opts)

-- Indent / outdent and keep the selection
map('v', '<Tab>',   '>gv', opts)
map('v', '<S-Tab>', '<gv', opts)

-- Leader utilities
map('n', '<leader>w',  ':set wrap!<CR>', opts)                 -- toggle wrap
map('n', '<leader>sp', ':setlocal spell! spelllang=en_us<CR>', opts)  -- toggle spell
map('n', '<leader>cw', ':%s/\\s\\+$//e<CR>', opts)             -- strip trailing whitespace
map('n', '<leader>h',  ':nohlsearch<CR>', opts)                -- clear search highlight
