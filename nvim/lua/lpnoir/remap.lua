vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use jk for exit from insert mode
-- vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, desc = 'Exit from insert mode' })

-- Move to end of line in insert mode
vim.keymap.set('i', '<C-e>', '<C-o>$', { desc = 'Move to end of line in insert mode' })

-- Save changes
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<Esc><cmd>silent! w<CR>', { desc = '[S]ave file' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search' })

-- Move selected lines up and down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected text up', silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected text down', silent = true })

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center', silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center', silent = true })

-- Indent in visual mode keeping selection
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and keep selection', silent = true })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and keep selection', silent = true })

-- Get the text highlighted in visual mode and prepare a substitute command for it
vim.keymap.set('v', '<leader>s', [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]])

-- YANK, PASTE AND DELETE
--
-- Yank in the system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = '[Y]ank in the system clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = '[Y]ank in the system clipboard' })
-- Paste preserving the clipboard
vim.keymap.set('x', 'p', '"_dP', { desc = '[P]aste preserving clipboard' })
-- Delete preserving clipboard
vim.keymap.set('v', '<leader>d', '"_d', { desc = '[D]elete Preserving clipboard' })
vim.keymap.set('n', '<leader>d', '"_d', { desc = '[D]elete Preserving clipboard' })
-- Paste from system clipboard
vim.keymap.set('v', '<leader>p', '"+P', { desc = '[P]aste from system clipboard' })
vim.keymap.set('n', '<leader>p', '"+P', { desc = '[P]aste from system clipboard' })
-- Change preserving clipboard
vim.keymap.set('v', '<leader>c', '"_c', { desc = '[C]hange Preserving clipboard' })
vim.keymap.set('n', '<leader>c', '"_c', { desc = '[C]hange Preserving clipboard' })

-- DIAGNOSTIC
--
-- Show error on popup, useful for error copy
vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float, { desc = 'Show error popup' })
-- Show diagnostics
vim.keymap.set('n', '<leader>sd', vim.diagnostic.setloclist, { desc = 'Show [D]iagnostics list' })

-- BUFFERS
--
-- Close the current buffer
vim.keymap.set('n', '<leader>x', ':bd<CR>', { desc = '[X] Close buffer', silent = true })
-- Buffer navigation
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>', { silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>bprevious<CR>', { silent = true })
-- Copy buffer relative path
vim.keymap.set('n', '<leader>Y', function()
  vim.fn.setreg('+', vim.fn.expand '%')
end, { desc = 'Copy relative path' })

-- WINDOW
--
-- Change window dimension
vim.keymap.set('n', 'º', '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', 'ª', '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '¬', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '∆', '<C-w>>', { desc = 'Increase window width' })

-- PLUGINS
--
-- Create keymap for the Tree Explorer
vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { desc = '[P]roject [V]iew', silent = true })

-- Show dashboard
vim.keymap.set('n', '<leader>h', '<cmd>Dashboard<CR>', { desc = 'Go to [H]ome' })

-- GIT
--
-- Show git status
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })
-- Show git preview hunk
vim.keymap.set('n', '<leader>gh', '<cmd>Gitsigns preview_hunk<CR>', { desc = '[G]it preview [H]unk', silent = true })

vim.keymap.set('n', '<leader>pr', function()
  vim.cmd 'silent !osascript -e \'tell application "Arc" to reload active tab of window 1\''
end, { desc = '[P]project browser [R]eload' })
