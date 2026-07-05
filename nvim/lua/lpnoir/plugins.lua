return {
  { -- Highlight todo, notes, etc in
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    'tpope/vim-surround',
  },
  { 'christoomey/vim-tmux-navigator' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    opts = {},
  },
}
