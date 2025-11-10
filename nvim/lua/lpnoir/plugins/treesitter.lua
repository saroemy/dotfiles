return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'python',
      'diff',
      'html',
      'css',
      'lua',
      'luadoc',
      'markdown',
      'query',
      'vim',
      'vimdoc',
      'php',
      'typescript',
      'twig',
    },
    auto_install = true,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        scope_incremental = 'grc',
        node_incremental = 'v',
        node_decremental = 'V',
      },
    },
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby', 'lua', 'css', 'php' },
    },
    indent = { enale = true, disable = { 'ruby', 'lua', 'css', 'php' } },
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  init = function()
    -- Registra Twig come parser per i file Jinja
    vim.treesitter.language.register('twig', 'jinja')

    -- Associa i file .jinja al filetype jinja
    vim.filetype.add {
      extension = {
        jinja = 'jinja',
      },
      pattern = {
        ['%.env%..*'] = 'sh',
      },
    }
  end,
}
