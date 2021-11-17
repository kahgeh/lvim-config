local M = {}

local function set_harpoon_keymaps()
	lvim.keys.normal_mode["<C-Space>"] = "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>"
	lvim.keys.normal_mode["tu"] = "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>"
	lvim.keys.normal_mode["te"] = "<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>"
	lvim.keys.normal_mode["cu"] = "<cmd>lua require('harpoon.term').sendCommand(1, 1)<CR>"
	lvim.keys.normal_mode["ce"] = "<cmd>lua require('harpoon.term').sendCommand(1, 2)<CR>"
	lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add Mark" }
	lvim.builtin.which_key.mappings["<leader>"] = {
		"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
		"Harpoon",
	}

	local whk_status, whk = pcall(require, "which-key")
	if not whk_status then
		return
	end
	whk.register({
		["<leader>4"] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "goto1" },
		["<leader>5"] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "goto2" },
		["<leader>6"] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "goto3" },
		["<leader>7"] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "goto4" },
	})
end

M.config = function()
	set_harpoon_keymaps()
end

return M
