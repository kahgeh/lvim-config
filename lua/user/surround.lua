function _G.escape_quotes(ch)
  if ch == "\"" then
    return  "\\\""
  end

  if ch == "\'" then
    return "\\\'"
  end

  return ch
end

function _G.surround_insert_word()
  local ch= vim.fn.input("character: ", "")
  ch = escape_quotes(ch)
  vim.cmd("call feedkeys(\"ysiw" .. ch .. "\")")
end

function _G.surround_insert()
  local ch= vim.fn.input("text object: ", "")
  ch = escape_quotes(ch)
  vim.cmd("call feedkeys(\"ysiw" .. ch .. "\")")
end

function _G.surround_delete()
  local ch= vim.fn.input("character: ", "")
  ch = escape_quotes(ch)
  vim.cmd("call feedkeys(\"ds" .. ch .. "\")")
end

function _G.surround_own_line()
  local ch= vim.fn.input("character: ", "")
  ch = escape_quotes(ch)
  vim.cmd("call feedkeys(\"ySS" .. ch .. "\")")
end

function _G.surround_change()
  local from = vim.fn.input("from: ", "")
  local to = vim.fn.input("to: ", "")
  from = escape_quotes(from)
  to = escape_quotes(to)
  vim.cmd("call feedkeys(\"cs" .. from .. to .. "\")")
end

local M = {}
function M.generate_whichkey_bindings()
  
  return {
    name = "+Surround",
    w = { ":lua surround_insert_word()<cr>", "surround around word" },
    c = { ":lua surround_change()<cr>", "change surround" },
    d = { ":lua surround_delete()<cr>", "delete surround" },
    l = { ":lua surround_own_line()<cr>", "surround around line" }
  }
end

return M


