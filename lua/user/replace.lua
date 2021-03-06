function _G.search_all_to_qfix()
  local old_text = vim.fn.input("search term: ", "")
  if old_text == '' then
    return
  end
  vim.cmd(":let @/='" .. old_text .. "'")
  vim.cmd("vimgrep ".. "/" .. old_text .. "/g `git ls-files`")
  vim.cmd(":copen")
end

local M = {}
function M.generate_whichkey_bindings()
  return {
    replace = {"\"sy:let @/=@s<cr>cgn", "replace"},
    global_search ={":lua search_all_to_qfix()<cr>", "search"}
  }
end
return M


