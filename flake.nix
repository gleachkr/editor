{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-tools.url = "github:gleachkr/nix-tools";
    razzle.url = "github:gleachkr/razzle.nvim";
    swine.url = "github:gleachkr/swine.nvim";
    lectic.url = "github:gleachkr/lectic";
  };

  outputs = inputs@{ self, nixpkgs, nix-tools, flake-utils, lectic, razzle, swine, ... }:
    let
      out = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "blink-cmp-spell"
                "rainbow_parentheses.vim"
                "vim-colorschemes"
                "vim-pug"
              ];
          };
          lectic-nvim = lectic.packages.${system}.lectic-nvim;
          swine-nvim = swine.packages.${system}.swine-nvim;
          razzle-nvim = razzle.packages.${system}.default;
          quint-lsp = nix-tools.packages.${system}.quint-lsp;
        in
        {

          packages.default = self.packages.${system}.lite;

          packages.heavy = pkgs.callPackage ./neovim {
            inherit lectic-nvim razzle-nvim swine-nvim;
            quint-language-server = quint-lsp;
          };

          packages.lite = pkgs.callPackage ./neovim {
            inherit lectic-nvim razzle-nvim swine-nvim;
          };

        };
    in
    flake-utils.lib.eachDefaultSystem out;
  }
