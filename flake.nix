{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    codecompanion = {
      url = "github:olimorris/codecompanion.nvim";
      flake = false;
    };
    vim-pandoc = {
      url = "github:vim-pandoc/vim-pandoc";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    let
      out = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {

          packages.default = pkgs.callPackage ./neovim { inherit (inputs) codecompanion vim-pandoc; };

        };
    in
    flake-utils.lib.eachDefaultSystem out;
  }
