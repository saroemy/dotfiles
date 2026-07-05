return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local ensure_installed = {
      'bash',
      'c',
      'python',
      'diff',
      'html',
      'css',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'php',
      'typescript',
      'twig',
    }
    require('nvim-treesitter').install(ensure_installed)

    -- Il branch main non ha più i moduli highlight/indent: si attivano per
    -- buffer con le API native di Neovim.
    local regex_highlighting = { ruby = true, lua = true, css = true, php = true }
    local indent_disabled = { ruby = true, lua = true, css = true, php = true }

    ---@param buf integer
    ---@param language string
    local function try_attach(buf, language)
      if not vim.treesitter.language.add(language) then
        return
      end
      vim.treesitter.start(buf, language)

      -- Alcuni linguaggi si appoggiano ancora all'highlighting regex di vim
      if regex_highlighting[language] then
        vim.bo[buf].syntax = 'on'
      end

      if not indent_disabled[language] and vim.treesitter.query.get(language, 'indents') ~= nil then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = require('nvim-treesitter').get_available()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('lpnoir-treesitter', { clear = true }),
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        if vim.tbl_contains(require('nvim-treesitter').get_installed 'parsers', language) then
          try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- auto-install dei parser mancanti alla prima apertura del filetype
          require('nvim-treesitter').install(language):await(function()
            try_attach(buf, language)
          end)
        else
          try_attach(buf, language)
        end
      end,
    })

    -- Incremental selection: il modulo non esiste più sul branch main, si usa
    -- quella nativa di Neovim 0.12 (`:help treesitter-incremental-selection`,
    -- `an` espande / `in` riduce) mantenendo i tasti di prima.
    vim.keymap.set('n', 'gnn', 'van', { remap = true, desc = 'Seleziona nodo treesitter' })
    vim.keymap.set('x', 'v', 'an', { remap = true, desc = 'Espandi selezione al nodo padre' })
    vim.keymap.set('x', 'V', 'in', { remap = true, desc = 'Riduci selezione al nodo figlio' })
  end,
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
        ['Podfile.*'] = 'ruby',
      },
    }
  end,
}
