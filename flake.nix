{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-tools.url = "github:gleachkr/nix-tools";
    razzle.url = "github:gleachkr/razzle.nvim";
    ihaskell.url = "github:IHaskell/IHaskell";
    lectic.url = "github:gleachkr/lectic";
  };

  outputs = inputs@{ self, nixpkgs, nix-tools, flake-utils, ihaskell, lectic, razzle, ... }:
    let
      out = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lectic-nvim = lectic.packages.${system}.lectic-nvim;
          razzle-nvim = razzle.packages.${system}.default;
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

          packages.default = self.packages.${system}.lite;

          packages.heavy = pkgs.callPackage ./neovim {
            inherit lectic-nvim razzle-nvim;
            ihaskell = ihaskell910Kernel;
            quint-language-server = quint-lsp;
          };

          packages.lite = pkgs.callPackage ./neovim {
            inherit lectic-nvim razzle-nvim;
          };

        };
    in
    flake-utils.lib.eachDefaultSystem out;
  }
