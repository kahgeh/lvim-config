if require("utils").check_lsp_client_active "poweshell_es" then
  return
end

require("lspconfig").powershell_es.setup {
  bundle_path = '/Users/kahgeh.tan/bin/pwsh_es',
  on_attach = require("lsp").common_on_attach
}
