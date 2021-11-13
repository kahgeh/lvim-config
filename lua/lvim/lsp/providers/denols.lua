local opts = {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern 'mod.ts'(fname)
  end,
}

return opts
