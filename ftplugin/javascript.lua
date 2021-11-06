lvim.lang.javascript.formatters = {
  {
    exe = "prettier",
    args = {},
  },
}

lvim.lang.javascript.linters = {
  {
    exe = "eslint_d",
    args = {},
  },
}

local dap_install = require "dap-install"
dap_install.config("jsnode_dbg", {})
