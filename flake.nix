{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-tools.url = "github:gleachkr/nix-tools";
    codecompanion = {
      url = "github:olimorris/codecompanion.nvim";
      flake = false;
    };
    vim-pandoc = {
      url = "github:vim-pandoc/vim-pandoc";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, nix-tools, flake-utils, ... }:
    let
      out = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          quint-lsp = nix-tools.packages.${system}.quint-lsp;
        in
        {

          packages.default = pkgs.callPackage ./neovim { 
            inherit (inputs) codecompanion  vim-pandoc; 
            quint-language-server = quint-lsp; 
          };

        };
    in
    flake-utils.lib.eachDefaultSystem out;
  }
