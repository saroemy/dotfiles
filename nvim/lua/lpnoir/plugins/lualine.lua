return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          file_status = true,
        },
      },
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          symbols = { alternate_file = '' },
        },
      },
    },
  },
}
