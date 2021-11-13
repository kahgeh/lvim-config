local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		filetypes = { "typescript" },
		args = {},
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { exe = "eslint_d", filetypes = { "typescript" } } })
