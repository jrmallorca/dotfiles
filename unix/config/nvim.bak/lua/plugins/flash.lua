local flash = require('flash')

flash.setup {
  keys = 'tnseriaodhc,gmvkxzplfuwybjq',
  search = {
    multi_window = true,
    incremental = true,
  },
  modes = {
    search = {
      enabled = true,
    },
    char = {
      enabled = false,
    }
  }
}
