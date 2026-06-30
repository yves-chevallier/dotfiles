-- Autocommands — ported from ~/.vimrc.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor to last position when reopening a file
autocmd('BufReadPost', {
  group = augroup('ResCur', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Strip trailing whitespace on save for code files
autocmd('BufWritePre', {
  group = augroup('StripWhitespace', { clear = true }),
  pattern = { '*.vim', '*.c', '*.h', '*.cpp', '*.hpp', '*.java', '*.php',
              '*.rb', '*.py', '*.asm', '*.yml', '*.yaml', '*.ini', '*.lua' },
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Insert include guards in new C/C++ headers
autocmd('BufNewFile', {
  group = augroup('IncludeGuards', { clear = true }),
  pattern = { '*.h', '*.hpp' },
  callback = function()
    local name = vim.fn.expand('%:t'):upper():gsub('%.', '_')
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
      '#ifndef ' .. name,
      '#define ' .. name,
      '',
      '',
      '#endif /* ' .. name .. ' */',
    })
    vim.api.nvim_win_set_cursor(0, { 4, 0 })
  end,
})

-- Per-filetype tweaks
local ft = augroup('FiletypeTweaks', { clear = true })
autocmd('FileType', {
  group = ft, pattern = { 'yaml' },
  callback = function() vim.opt_local.tabstop = 2 end,
})
autocmd('FileType', {
  group = ft, pattern = { 'python' },
  callback = function() vim.opt_local.textwidth = 79 end,
})

-- Briefly highlight yanked text (modern nicety)
autocmd('TextYankPost', {
  group = augroup('HighlightYank', { clear = true }),
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})
