function _G.load_deno_lsp()
  lvim.lang.typescript.lsp = {
    provider = "denols",
    setup = {
      cmd = {
        DATA_PATH .. "/lspinstall/deno/bin/deno",
        "lsp",
      },
      filetypes = {"typescript"},
      init_options = {
        enable = true,
        lint = true,
        unstable = true,
      },
      root_dir = require("lspconfig").util.root_pattern("mod.ts"),
    },
  }
  require("lsp").setup "typescript"
  require'lspconfig'.denols.setup{}
end

local M = {}
function M.generate_whichkey_bindings()
  return {"<cmd>lua load_deno_lsp()<cr>", "load deno lsp"}
end
return M

