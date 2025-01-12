{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-tools.url = "github:gleachkr/nix-tools";
    ihaskell.url = "github:IHaskell/IHaskell";
    codecompanion = {
      url = "github:olimorris/codecompanion.nvim";
      flake = false;
    };
    vim-pandoc = {
      url = "github:vim-pandoc/vim-pandoc";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-tools, flake-utils, ihaskell, ... }:
    let
      out = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          quint-lsp = nix-tools.packages.${system}.quint-lsp;
          ihaskell910 = ihaskell.packages.${system}.ihaskell-env-ghc910;
          ihaskell910Kernel = let
            kernelFile = {
              display_name = "Haskell";
              argv = [
                "${ihaskell910}/bin/ihaskell"
                "kernel"
                "{connection_file}"
                "+RTS"
              ] ++ (pkgs.lib.splitString " " "-M3g -N2") ++ [
                "-RTS"
              ];
              language = "haskell";
            };
          in
            pkgs.runCommand "ihaskell-kernel" {} ''
              export kerneldir=$out/kernels/haskell
              mkdir -p $kerneldir
              echo '${builtins.toJSON kernelFile}' > $kerneldir/kernel.json
            '';
        in
        {

          packages.default = pkgs.callPackage ./neovim { 
            inherit (inputs) codecompanion  vim-pandoc; 
            ihaskell = ihaskell910Kernel;
            quint-language-server = quint-lsp; 
          };

        };
    in
    flake-utils.lib.eachDefaultSystem out;
  }
