return {
  'supermaven-inc/supermaven-nvim',
  opts = {
    keymaps = {
      accept_suggestion = '<Tab>',
      clear_suggestion = '<C-j>',
      accept_word = '<C-l>',
    },
    ignore_filetypes = { 'codecompanion', 'gitcommit' },
  },
}
