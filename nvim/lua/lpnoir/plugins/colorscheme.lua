-- Scegli il colorscheme in base alla variabile d'ambiente DEV_THEME (definita in .zshrc),
-- la stessa usata da tmux.conf: 'catppuccin' oppure qualsiasi altro valore per nord
local dev_theme = vim.env.DEV_THEME

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

      if dev_theme == 'catppuccin' then
        vim.cmd.colorscheme 'catppuccin-frappe'
      end
    end,
  },
  {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
      },
    },
    config = function(_, opts)
      require('nord').setup(opts)

      if dev_theme ~= 'catppuccin' then
        vim.cmd.colorscheme 'nord'
      end
    end,
  },
}
