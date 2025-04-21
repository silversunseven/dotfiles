local nmap = require("rxbn.util.keymap").nmap
local vmap = require("rxbn.util.keymap").vmap
local xmap = require("rxbn.util.keymap").xmap

nmap({
  "<leader>pv",
  function()
    require("telescope.builtin").find_files({
      hidden = true,
      file_ignore_patterns = { ".git/" }, -- Ignore .git directory
    })
  end,
})

-- Using leader r for file executions
nmap({
  "<leader>r",
  function()
    local filetype = vim.bo.filetype
    local filepath = vim.fn.expand("%")

    vim.cmd("w")

    -- Function to open a floating terminal
    local function run_in_floating_terminal(command)
      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.8)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      -- Create a floating window
      local term_buf = vim.api.nvim_create_buf(false, true)
      local term_win = vim.api.nvim_open_win(term_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
      })

      vim.fn.termopen(command .. "; echo ''; echo 'Press ENTER to close...'; read _", {
        on_exit = function()
          vim.api.nvim_win_close(term_win, true)
        end,
      })

      vim.cmd("startinsert")
    end

    -- Run the appropriate script based on file type
    if filetype == "lua" then
      run_in_floating_terminal("lua " .. filepath)
    elseif filetype == "python" then
      run_in_floating_terminal("python3 " .. filepath)
    elseif filetype == "sh" then
      run_in_floating_terminal("bash " .. filepath)
    else
      print("No run command set for filetype: " .. filetype)
    end
  end,
})

nmap({ "]q", "<Cmd>cnext<CR>zz" })
nmap({ "[q", "<Cmd>cprev<CR>zz" })

xmap({ "<leader>p", [["_dP]] })

nmap({ "J", "mzJ`z" })
nmap({ "<c-d>", "<c-d>zz" })
nmap({ "<c-u>", "<c-u>zz" })
nmap({ "n", "nzzzv" })
nmap({ "N", "Nzzzv" })
nmap({ "<c-o>", "<c-o>zz" })
nmap({ "<c-i>", "<c-i>zz" })
nmap({ "}", "}zz" })
nmap({ "{", "{zz" })

vmap({ "J", ":m '>+1<CR>gv=gv" })
vmap({ "K", ":m '<-2<CR>gv=gv" })

nmap({ "<leader>y", '"+y' })
nmap({ "<leader>Y", '"+Y' })

vmap({ "<leader>y", '"+y' })

--using leader r for file exections
--nmap({ "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] })

nmap({ "<c-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>" })
nmap({ "<c-g>", "<Cmd>silent !tmux neww tmux-sshionizer<CR>" })
