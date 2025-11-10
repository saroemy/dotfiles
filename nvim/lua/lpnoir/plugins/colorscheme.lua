return {
  {
    'catppuccin/nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent_background = true,
      styles = {
        comments = { 'italic' }, -- Italicize comments
        conditionals = { 'italic' }, -- Italicize conditionals
        keywords = { 'italic' }, -- Bold keywords
        -- operators = { 'italic' },
        -- types = { 'italic' },
        booleans = { 'italic' }, -- Italicize booleans
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)

      -- inserisci load the colorscheme here
      vim.cmd.colorscheme 'catppuccin-frappe'
    end,
  },
}
