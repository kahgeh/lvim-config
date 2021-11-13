local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = { "javascript" },
    args = {},
  },
}
local dap_install = require "dap-install"
dap_install.config("jsnode_dbg", {})
