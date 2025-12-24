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
          max_length = vim.o.columns,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          symbols = { alternate_file = '' },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
