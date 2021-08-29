-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "spacegray"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""

-- edit a default keymapping
lvim.keys.normal_mode["<A-CR>"] = ":lua vim.lsp.buf.code_action()<cr>"
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true})

lvim.builtin.treesitter.foldmethod = "expr"
lvim.builtin.treesitter.foldexpr = "nvim_treesitter#foldexpr()"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
lvim.builtin.which_key.mappings.E ={ "<cmd>TroubleToggle<cr>", "Error/Warnings" }
lvim.builtin.which_key.mappings.R = {
  name= "+Rust",
  v = { ":lua require('ls-crates').insert_latest_version()<cr>", "insert latest crate version" }
}
lvim.builtin.which_key.mappings.F ={"<cmd>setlocal foldmethod=syntax<cr>", "fold based on syntax"}
lvim.builtin.which_key.mappings.t = {
  name="+Terminal",
  b = {"<cmd>ToggleTerm direction=horizontal size=10<cr>", "bottom terminal"},
  r = {"<cmd>ToggleTerm direction=vertical size=85<cr>", "right terminal"},
  w = {"<cmd>vsp +term<cr>", "right terminal"}
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.bufferline.active = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

lvim.lang.ps1.lsp.setup.bundle_path = '/Users/kahgeh.tan/bin/pwsh_es'
-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "kahgeh/ls-crates.nvim",
    config= function()
      require "ls-crates"
    end,
    ft={'toml'}
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/zen-mode.nvim",
  },
  {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  {
    "Pocco81/AutoSave.nvim",
    config = function()
      require('autoSave').setup({
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 60000
    })
    end
  },
  {"RishabhRD/popfix"},
  {
    "RishabhRD/nvim-lsputils",
    config = function ()
      vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    end
  },
  {
    "blackCauldron7/surround.nvim",
    config = function()
      require "surround".setup {}
    end
  }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "FileType", "rust", "set matchpairs+=<:>" },
  { "FileType", "csharp", "set matchpairs+=<:>" },
  { "FileType", "typescript", "set matchpairs+=<:>"}
}

