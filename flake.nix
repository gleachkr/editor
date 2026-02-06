{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-tools.url = "github:gleachkr/nix-tools";
    razzle.url = "github:gleachkr/razzle.nvim";
    lectic.url = "github:gleachkr/lectic";
  };

  outputs = { self, nixpkgs, nix-tools, flake-utils, lectic, razzle, ... }:
    let
      out = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lectic-nvim = lectic.packages.${system}.lectic-nvim;
          razzle-nvim = razzle.packages.${system}.default;
          quint-lsp = nix-tools.packages.${system}.quint-lsp;
        in
        {

          packages.default = self.packages.${system}.lite;

          packages.heavy = pkgs.callPackage ./neovim {
            inherit lectic-nvim razzle-nvim;
            quint-language-server = quint-lsp;
          };

          packages.lite = pkgs.callPackage ./neovim {
            inherit lectic-nvim razzle-nvim;
          };

        };
    in
    flake-utils.lib.eachDefaultSystem out;
  }
