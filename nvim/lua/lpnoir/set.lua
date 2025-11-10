-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make line numbers default and enable relative line numbers for easier navigation between lines
vim.opt.number = true
vim.opt.relativenumber = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set indentation to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 600

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable break indent
vim.opt.breakindent = true

-- Optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Save undo history and set max undo memory
vim.opt.undofile = true
vim.opt.undolevels = 1000

-- Views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Enable automatic reload when files change externally
vim.opt.autoread = true

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Closes empty, unmodified buffers when you open a new one
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    -- Find all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Check if the buffer is empty, unmodified, and loaded
      if
        vim.api.nvim_buf_is_loaded(buf)
        and vim.api.nvim_buf_get_name(buf) == ''
        and not vim.api.nvim_get_option_value('modified', { buf = buf })
        and buf ~= vim.api.nvim_get_current_buf()
        and vim.api.nvim_get_option_value('buftype', { buf = buf }) == ''
      then
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end,
})
