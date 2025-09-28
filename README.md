# Superfile.nvim
Neovim plugin for superfile


Installation :

Lazy :

  just paste `"anaypurohit0907/Superfile.nvim"` in your init file along with the other plugins, then do a Lazy sync.

  the default keybing is <C-s> , to change it add the following to your neovim config:
  `
    {
  "anaypurohit0907/superfile.nvim",
  main = "superfile",        
  opts = { key = false },     
  keys = {
    {
      "<C-s>", --change this to any keybing you want
      function() require("superfile").open() end,  
      mode = { "n", "t" },
      desc = "Open/Focus Superfile",
      silent = true,
    },
  },
}

  `



Usage 

  cntrl+s : to launch Superfile 
  esc to exit.

  please refer https://github.com/yorukot/superfile  for all controls of superfile.
