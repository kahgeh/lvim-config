local M = {}

M.config = function()
  local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
  end

  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  local dapinstall_path = vim.fn.stdpath("data") .. "/dapinstall"

  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {dapinstall_path .. '/jsnode/vscode-node-debug2/out/src/nodeDebug.js'},
  }

  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {dapinstall_path .. "/chrome/vscode-chrome-debug/out/src/chromeDebug.js"}
  }

  local dotnetdbg_path = dapinstall_path .. "/dnetcs/netcoredbg/netcoredbg"
  dap.adapters.netcoredbg = {
    type = 'executable',
    command = dotnetdbg_path,
    args = {'--interpreter=vscode'}
  }

  local lldb_path = vim.fn.expand(dapinstall_path .. "/codelldb/extension/adapter/codelldb")
  dap.adapters.lldb = function(on_adapter)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)

    -- change this!
    local cmd = lldb_path

    local handle, pid_or_err
    local opts = {
      stdio = {nil, stdout, stderr},
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
      stdout:close()
      stderr:close()
      handle:close()
      if code ~= 0 then
        print("codelldb exited with code", code)
      end
    end)
    assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        local port = chunk:match('Listening on port (%d+)')
        if port then
          vim.schedule(function()
            on_adapter({
              type = 'server',
              host = '127.0.0.1',
              port = port
            })
          end)
        else
          vim.schedule(function()
            require("dap.repl").append(chunk)
          end)
        end
      end
    end)
    stderr:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Neovim attach",
      host = function()
        local value = vim.fn.input "Host [127.0.0.1]: "
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input "Port: ")
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
    },
  }

  dap.configurations.typescript = {
    {
      type = "node2",
      name = "node attach",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "chrome",
      name = "chrome",
      request = "attach",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.configurations.typescriptreact = {
    {
      type = "chrome",
      request = "chrome attach",
      name = "chrome",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.configurations.javascript = {
    {
      type = "node2",
      name = "node attach",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "node2",
      name = "node launch",
      request = "launch",
      program = "${workspaceFolder}/${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "chrome",
      request = "attach",
      name = "chrome",
      program = "${file}",
      port = 9222,
      webRoot = "${workspaceFolder}",
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.configurations.javascriptreact = {
    {
      type = "chrome",
      name = "chrome attach",
      request = "attach",
      program = "${file}",
      -- cwd = vim.fn.getcwd(),
      -- sourceMaps = true,
      -- protocol = "inspector",
      port = 9222,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.configurations.cs = {
    {
      type = "netcoredbg",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd(), 'file')
      end,
    },
  }

  dap.configurations.rust = {
    {
      name = "Debug",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', sep_os_replacer(vim.fn.getcwd() .. "/target/debug/"),'file')
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      args = {},
    },
  }
  -- dap.set_log_level('TRACE')
end

return M
