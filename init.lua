local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'nvim-telescope/telescope.nvim',    tag = '0.1.5',       dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'ThePrimeagen/vim-be-good' },
    { 'numToStr/Comment.nvim' },
    { 'prichrd/netrw.nvim' },
    { 'simrat39/rust-tools.nvim' },
    { "catppuccin/nvim",                  name = "catppuccin", priority = 1000 },
})

local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    }
})

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.format_on_save({
    servers = {
        ['prettier'] = { 'astro', 'javascript', 'typescript', 'html', 'css', 'svelte', 'json' },
        ['autopep8'] = { 'python' }
    }
})

require('mason-lspconfig').setup({})

require('Comment').setup()

require('netrw').setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

require("catppuccin").setup({
    flavour = "macchiato",
})

vim.cmd.colorscheme("catppuccin")

local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})

require("nvim-treesitter.configs").setup({
    ensure_installed = { "javascript", "typescript", "svelte", "astro", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.g.netrw_banner = 0

vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set('n', '<leader>w', '<C-w>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<leader>pc", "c<ESC>\"+p<ESC>")
vim.keymap.set("n", "<leader>pc", "<ESC>\"+pa<ESC>")

vim.keymap.set({ "n", "v", "i" }, "<C-s>", function()
    vim.cmd("w")
    vim.lsp.buf.format()
end)
