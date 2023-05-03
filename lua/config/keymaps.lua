-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- While in neovim, use <leader>sk to display active keymaps

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local wk = require("which-key")

wk.register({
  ["<leader>p"] = { "<cmd>ChatGPT<cr>", "ChatGPT" },
})

local function keymap(mode, lhs, rhs, opt)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opt)
  end
end

-- For neorg if anything
vim.g.maplocalleader = ","

-- Remove default j/k colliding with delaytrain config
vim.keymap.del("n", "j")
vim.keymap.del("n", "k")

-- Normal --
-- Better window navigation
-- Ctrl + h/j/k/l to change focus
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Center line on screen
-- After search next
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-Right>", ":bnext<CR>", opts)
keymap("n", "<A-Left>", ":bprevious<CR>", opts)
keymap("n", "<A-Down>", ":bd<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Tweak yank behavior
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Debugging
local prefix = ":lua require('dap')."
keymap("n", "<F5>", prefix .. "continue()<CR>", opts)
keymap("n", "<F8>", prefix .. "set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<F9>", prefix .. "toggle_breakpoint()<CR>", opts)
keymap("n", "<leader><F9>", prefix .. "set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<F10>", prefix .. "step_over()<CR>", opts)
keymap("n", "<F11>", prefix .. "step_into()<CR>", opts)
keymap("n", "<leader><F11>", prefix .. "step_out()<CR>", opts)
keymap("n", "<leader>dl", prefix .. "run_last()<CR>", opts)
