return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      -- Evita il conflitto con l'incremental selection nativa di Neovim>=0.12
      -- (`an`/`in`, vedi `:help treesitter-incremental-selection`)
      mappings = {
        around_next = 'aa',
        inside_next = 'ii',
      },
      n_lines = 500,
    }

    -- Auto pairs opening symbols, auto close parentesis etc.
    require('mini.pairs').setup()

    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
