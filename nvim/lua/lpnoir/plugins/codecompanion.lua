return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'MunifTanjim/nui.nvim',
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    -- {
    --   -- support for image pasting
    --   'HakonHarnes/img-clip.nvim',
    --   event = 'VeryLazy',
    --   opts = {
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },
  opts = {
    language = 'Italian',
  },
  config = function(_, opts)
    require('codecompanion').setup(opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
  end,
}
