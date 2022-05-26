-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/liujun/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/liujun/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/liujun/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/liujun/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/liujun/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fcomment\18configs.tools\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://ghproxy.com/https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\np\0\0\3\0\5\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0B\0\1\1K\0\1\0\fluasnip\16configs.cmp\tload luasnip.loaders.from_vscode\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://ghproxy.com/https://github.com/L3MON4D3/LuaSnip"
  },
  ["accelerated-jk"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/accelerated-jk",
    url = "https://ghproxy.com/https://github.com/rhysd/accelerated-jk"
  },
  ["alpha-nvim"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0036\0\0\0009\0\1\0L\0\2\0\18is_not_vscode\tnvim\0" },
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15alpha_nvim\15configs.ui\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/alpha-nvim",
    url = "https://ghproxy.com/https://github.com/goolord/alpha-nvim"
  },
  ["auto-session"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0036\0\0\0009\0\1\0L\0\2\0\18is_not_vscode\tnvim\0" },
    config = { "\27LJ\2\n…\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\3\0\0\a~/\15~/Projects\1\0\1\14log_level\tinfo\nsetup\17auto-session\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/auto-session",
    url = "https://ghproxy.com/https://github.com/rmagatti/auto-session"
  },
  ["bufdelete.nvim"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0036\0\0\0009\0\1\0L\0\2\0\18is_not_vscode\tnvim\0" },
    config = { "\27LJ\2\n9\0\0\4\0\2\0\b6\0\0\0'\2\1\0B\0\2\0029\0\1\0)\2\0\0+\3\2\0B\0\3\1K\0\1\0\14bufdelete\frequire@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0)\2\0\0B\0\2\1K\0\1\0\15bufwipeout\14bufdelete\frequirel\1\0\5\0\b\0\0156\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0003\4\5\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0003\4\a\0B\0\4\1K\0\1\0\0\15<Leader>bw\0\15<Leader>bd\6n\bset\vkeymap\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/bufdelete.nvim",
    url = "https://ghproxy.com/https://github.com/famiu/bufdelete.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15cmp_buffer\16configs.cmp\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://ghproxy.com/https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://ghproxy.com/https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://ghproxy.com/https://github.com/hrsh7th/cmp-nvim-lua"
  },
  cmp_luasnip = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://ghproxy.com/https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0036\0\0\0009\0\1\0L\0\2\0\18is_not_vscode\tnvim\0" },
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rdiffview\18configs.tools\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://ghproxy.com/https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0036\0\0\0009\0\1\0L\0\2\0\18is_not_vscode\tnvim\0" },
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rdressing\15configs.ui\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/dressing.nvim",
    url = "https://ghproxy.com/https://github.com/stevearc/dressing.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://ghproxy.com/https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rgitsigns\18configs.tools\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://ghproxy.com/https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://ghproxy.com/https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://ghproxy.com/https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp_signature.nvim"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\18lsp_signature\16configs.lsp\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://ghproxy.com/https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\flualine\15configs.ui\frequire\0" },
    load_after = {
      ["nvim-web-devicons"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://ghproxy.com/https://github.com/hoob3rt/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fnull_ls\16configs.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://ghproxy.com/https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\19nvim_autopairs\16configs.cmp\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://ghproxy.com/https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp_luasnip", "cmp-nvim-lsp", "LuaSnip", "cmp-buffer", "nvim-autopairs", "tabout.nvim", "cmp-nvim-lua" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rnvim_cmp\16configs.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://ghproxy.com/https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://ghproxy.com/https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-jdtls"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-jdtls",
    url = "https://ghproxy.com/https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp_signature.nvim", "symbols-outline.nvim" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\19nvim_lspconfig\16configs.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://ghproxy.com/https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lua-guide"] = {
    loaded = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/start/nvim-lua-guide",
    url = "https://ghproxy.com/https://github.com/nanotee/nvim-lua-guide"
  },
  ["nvim-notify"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0036\0\0\0009\0\1\0L\0\2\0\18is_not_vscode\tnvim\0" },
    config = { "\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://ghproxy.com/https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14nvim_tree\15configs.ui\frequire\0" },
    load_after = {
      ["nvim-web-devicons"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://ghproxy.com/https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "vim-matchup", "nvim-ts-rainbow", "nvim-ts-context-commentstring", "nvim-treesitter-context", "nvim-treesitter-textobjects", "nvim-ts-autotag" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\nJ\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20nvim_treesitter\23configs.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://ghproxy.com/https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23treesitter-context\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-context",
    url = "https://ghproxy.com/https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { "\27LJ\2\nV\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0 nvim_treesitter_textobjects\23configs.treesitter\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://ghproxy.com/https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\ng\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fautotag\1\0\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://ghproxy.com/https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    config = { "\27LJ\2\nX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\"nvim_ts_context_commentstring\23configs.treesitter\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://ghproxy.com/https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    config = { "\27LJ\2\nJ\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20nvim_ts_tainbow\23configs.treesitter\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://ghproxy.com/https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    after = { "lualine.nvim", "nvim-tree.lua" },
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://ghproxy.com/https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://ghproxy.com/https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://ghproxy.com/https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fproject\22configs.telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/project.nvim",
    url = "https://ghproxy.com/https://github.com/ahmedkhalf/project.nvim"
  },
  sonokai = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/sonokai",
    url = "https://ghproxy.com/https://github.com/sainnhe/sonokai"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/startuptime.vim",
    url = "https://ghproxy.com/https://github.com/tweekmonster/startuptime.vim"
  },
  ["symbols-outline.nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://ghproxy.com/https://github.com/simrat39/symbols-outline.nvim"
  },
  ["tabout.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vtabout\16configs.cmp\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/tabout.nvim",
    url = "https://ghproxy.com/https://github.com/abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nN\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\25telescope_fzf_native\22configs.telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://ghproxy.com/https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "project.nvim", "telescope-fzf-native.nvim" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22configs.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://ghproxy.com/https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://ghproxy.com/https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "Glow", "Lazygit" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15toggleterm\17configs.misc\frequire\0" },
    keys = { { "", "<C-\\>" }, { "", "<Leader>gg" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://ghproxy.com/https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim",
    url = "https://ghproxy.com/https://github.com/folke/tokyonight.nvim"
  },
  ["vim-delve"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-delve",
    url = "https://ghproxy.com/https://github.com/sebdah/vim-delve"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\nv\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0W\t\t\t\t\tnmap <leader>ga <Plug>(EasyAlign)\n\t\t\t\t\txmap <leader>ga <Plug>(EasyAlign)\n\t\t\t\t\bcmd\bvim\0" },
    keys = { { "", "<leader>ga" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://ghproxy.com/https://github.com/junegunn/vim-easy-align"
  },
  ["vim-fugitive"] = {
    commands = { "G", "Git" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://ghproxy.com/https://github.com/tpope/vim-fugitive"
  },
  ["vim-matchup"] = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    config = { "\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\16vim_matchup\23configs.treesitter\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://ghproxy.com/https://github.com/andymass/vim-matchup"
  },
  ["vim-quickrun"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\17vim_quickrun\18configs.tools\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-quickrun",
    url = "https://ghproxy.com/https://github.com/thinca/vim-quickrun"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\17vim_sandwich\17configs.misc\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-sandwich",
    url = "https://ghproxy.com/https://github.com/machakann/vim-sandwich"
  },
  ["vim-signature"] = {
    after_files = { "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-signature/after/plugin/signature.vim" },
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-signature",
    url = "https://ghproxy.com/https://github.com/kshenoy/vim-signature"
  },
  ["vim-test"] = {
    cond = { "\27LJ\2\n(\0\0\1\0\3\0\0056\0\0\0009\0\1\0009\0\2\0\19\0\0\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rvim_test\18configs.tools\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-test",
    url = "https://ghproxy.com/https://github.com/vim-test/vim-test"
  },
  ["vim-textobj-indent"] = {
    config = { "\27LJ\2\nG\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\23vim_textobj_indent\17configs.misc\frequire\0" },
    load_after = {
      ["vim-textobj-user"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-textobj-indent",
    url = "https://ghproxy.com/https://github.com/kana/vim-textobj-indent"
  },
  ["vim-textobj-parameter"] = {
    config = { "\27LJ\2\nJ\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\26vim_textobj_parameter\17configs.misc\frequire\0" },
    load_after = {
      ["vim-textobj-user"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-textobj-parameter",
    url = "https://ghproxy.com/https://github.com/sgur/vim-textobj-parameter"
  },
  ["vim-textobj-user"] = {
    after = { "vim-textobj-indent", "vim-textobj-parameter" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-textobj-user",
    url = "https://ghproxy.com/https://github.com/kana/vim-textobj-user"
  },
  ["vim-translator"] = {
    cond = { "\27LJ\2\n&\0\0\1\0\2\0\0046\0\0\0009\0\1\0\19\0\0\0L\0\2\0\14is_vscode\tnvim\0" },
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\19vim_translator\17configs.misc\frequire\0" },
    keys = { { "", "<leader>tr" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/liujun/.local/share/nvim/site/pack/packer/opt/vim-translator",
    url = "https://ghproxy.com/https://github.com/voldikss/vim-translator"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: sonokai
time([[Setup for sonokai]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fsonokai\15configs.ui\frequire\0", "setup", "sonokai")
time([[Setup for sonokai]], false)
-- Setup for: tokyonight.nvim
time([[Setup for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15tokyonight\15configs.ui\frequire\0", "setup", "tokyonight.nvim")
time([[Setup for tokyonight.nvim]], false)
-- Setup for: accelerated-jk
time([[Setup for accelerated-jk]], true)
try_loadstring("\27LJ\2\n„\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0e\t\t\t\t\tnmap <silent>n <Plug>(accelerated_jk_gj)\n\t\t\t\t\tnmap <silent>e <Plug>(accelerated_jk_gk)\n\t\t\t\t\bcmd\bvim\0", "setup", "accelerated-jk")
time([[Setup for accelerated-jk]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\21indent_blankline\17configs.misc\frequire\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: vim-sandwich
time([[Setup for vim-sandwich]], true)
try_loadstring("\27LJ\2\nJ\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0-textobj_sandwich_no_default_key_mappings\6g\bvim\0", "setup", "vim-sandwich")
time([[Setup for vim-sandwich]], false)
-- Setup for: symbols-outline.nvim
time([[Setup for symbols-outline.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20symbols_outline\16configs.lsp\frequire\0", "setup", "symbols-outline.nvim")
time([[Setup for symbols-outline.nvim]], false)
-- Setup for: vim-textobj-indent
time([[Setup for vim-textobj-indent]], true)
try_loadstring("\27LJ\2\nH\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0+textobj_indent_no_default_key_mappings\6g\bvim\0", "setup", "vim-textobj-indent")
time([[Setup for vim-textobj-indent]], false)
-- Setup for: vim-textobj-parameter
time([[Setup for vim-textobj-parameter]], true)
try_loadstring("\27LJ\2\nK\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0.textobj_parameter_no_default_key_mappings\6g\bvim\0", "setup", "vim-textobj-parameter")
time([[Setup for vim-textobj-parameter]], false)
-- Conditional loads
time([[Conditional loading of sonokai]], true)
  require("packer.load")({"sonokai"}, {}, _G.packer_plugins)
time([[Conditional loading of sonokai]], false)
time([[Conditional loading of nvim-web-devicons]], true)
  require("packer.load")({"nvim-web-devicons"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-web-devicons]], false)
time([[Conditional loading of lualine.nvim]], true)
  require("packer.load")({"lualine.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of lualine.nvim]], false)
time([[Conditional loading of tokyonight.nvim]], true)
  require("packer.load")({"tokyonight.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of tokyonight.nvim]], false)
time([[Conditional loading of nvim-tree.lua]], true)
  require("packer.load")({"nvim-tree.lua"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-tree.lua]], false)
time([[Conditional loading of lsp_signature.nvim]], true)
  require("packer.load")({"lsp_signature.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of lsp_signature.nvim]], false)
time([[Conditional loading of dressing.nvim]], true)
  require("packer.load")({"dressing.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of dressing.nvim]], false)
time([[Conditional loading of alpha-nvim]], true)
  require("packer.load")({"alpha-nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of alpha-nvim]], false)
time([[Conditional loading of bufdelete.nvim]], true)
  require("packer.load")({"bufdelete.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of bufdelete.nvim]], false)
time([[Conditional loading of nvim-notify]], true)
  require("packer.load")({"nvim-notify"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-notify]], false)
time([[Conditional loading of auto-session]], true)
  require("packer.load")({"auto-session"}, {}, _G.packer_plugins)
time([[Conditional loading of auto-session]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Lazygit lua require("packer.load")({'toggleterm.nvim'}, { cmd = "Lazygit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'startuptime.vim'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Glow lua require("packer.load")({'toggleterm.nvim'}, { cmd = "Glow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <Leader>gg <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>Leader>gg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-\> <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>C-\\>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ga <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>leader>ga", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>tr <cmd>lua require("packer.load")({'vim-translator'}, { keys = "<lt>leader>tr", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType rust ++once lua require("packer.load")({'vim-quickrun', 'vim-test'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'nvim-jdtls', 'vim-test'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-quickrun', 'vim-test', 'vim-delve'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'null-ls.nvim', 'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'Comment.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'vim-matchup', 'accelerated-jk'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'telescope.nvim', 'nvim-colorizer.lua', 'indent-blankline.nvim', 'nvim-lspconfig', 'vim-signature'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'todo-comments.nvim', 'vim-sandwich', 'vim-textobj-user', 'gitsigns.nvim', 'nvim-treesitter'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
