{ wrapNeovimUnstable, 
  stdenv, 
  gum, 
  symlinkJoin, 
  writeShellApplication, 
  neovim-unwrapped, 
  vimPlugins, 
  ripgrep,
  gh,
  gitMinimal,
  nil,
  bash-language-server,
  typescript-language-server,
  vscode-langservers-extracted,
  vim-language-server,
  lua-language-server,
  yaml-language-server,
  pyright,
  quint-language-server ? null,
  lectic-nvim,
  swine-nvim,
  nippy-nvim,
  razzle-nvim,
  texlab,
  lib,
}: 
let 
    nvimRtp = stdenv.mkDerivation {
      name = "nvim-rtp";
      src = ./.;

      buildPhase = ''
        mkdir -p $out/nvim
        mkdir -p $out/lua
        rm init.lua
      '';

      installPhase = ''
        if [ -d "lua" ]; then
          cp -r lua $out/lua
          rm -r lua
        fi
        if [ -d "after" ]; then
            cp -r after $out/after
            rm -r after
        fi
        if [ ! -z "$(ls -A)" ]; then
            cp -r -- * $out/nvim
        fi
      '';
    };

    nixpkgsPlugins = with vimPlugins; [
      nvim-treesitter.withAllGrammars
      luasnip
      blink-cmp
      blink-cmp-git
      blink-cmp-latex
      blink-cmp-spell
      lean-nvim
      nvim-lspconfig
      plenary-nvim
      which-key-nvim
      nvim-web-devicons
      zen-mode-nvim
      undotree
      vimtex
      solarized-nvim
      vim-hybrid
      Recover-vim
      mediawiki-vim
      vim-colorschemes
      zenburn
      gv-vim
      limelight-vim
      rainbow_parentheses-vim
      seoul256-vim
      vim-easy-align
      vim-sneak
      vim-sexp
      vim-sexp-mappings-for-regular-people
      vim-pug
      vim-javascript
      vim-fugitive
      vim-repeat
      vim-rhubarb
      vim-racket
      nvim-colorizer-lua
      oceanic-next
      nightfox-nvim
      vim-jsx-pretty
      vim-nix
      Coqtail
      nvim-unception
      vim-loves-dafny
      fidget-nvim
      nvim-lightbulb
      lazydev-nvim
      friendly-snippets
      vim-obsession
      octo-nvim
      oil-nvim
      quarto-nvim
      otter-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      lectic-nvim
      swine-nvim
      nippy-nvim
      razzle-nvim
      diffview-nvim
      aerial-nvim
    ];

    plugins = nixpkgsPlugins ++ [ ];

    externalPackages = [
      ripgrep
      gh
      gitMinimal
      nil
      lua-language-server
      texlab
      yaml-language-server
      pyright
      quint-language-server
      bash-language-server
      typescript-language-server
      vscode-langservers-extracted
      vim-language-server
      # could add more - basically want anything that's not likely to depend on
      # the project. (ruff is deliberately absent: projects often pin its
      # version for formatting, so we pick it up from PATH instead.)
    ];

    neovim = wrapNeovimUnstable neovim-unwrapped { 

      inherit plugins;
      withPython3 = true;
      withNodeJs = true;
      extraPython3Packages = pyPkgs: with pyPkgs; [
        pynvim
        jupyter-client
        cairosvg
        pnglatex
        plotly
        pyperclip
        ipykernel
      ];
      luaRcContent = '' 
      vim.loader.enable()
      vim.opt.rtp:prepend('${nvimRtp}/lua')
      '' + builtins.readFile ./init.lua + ''
      vim.opt.rtp:prepend('${nvimRtp}/nvim')
      vim.opt.rtp:prepend('${nvimRtp}/after')
      '';
      wrapperArgs = [
        "--set" "NVIM_APPNAME" "nvim-nix"
        "--prefix" "PATH" ":" "'${lib.makeBinPath externalPackages}'"
      ];
    };

    neovimSession = writeShellApplication {
      name = "sesh";
      runtimeInputs = [
        neovim
        gum
      ];
      text = ''
        shopt -s nullglob #makes SESSIONS empty if there aren't any sessions

        SESSIONS=(~/.cache/nvim-nix/*.pipe)
        CMD="$(gum choose NEW-SESSION "''${SESSIONS[@]}")"

        if [ "$CMD" == NEW-SESSION ]; then
            SESSION_PATH="$HOME/.cache/nvim-nix/$(gum input --placeholder "session name?").pipe"
            if [ -e "$SESSION_PATH" ]; then echo "hold your horses!"; exit; fi
            nohup nvim --headless --listen "$SESSION_PATH" > /dev/null &
            until [ -S "$SESSION_PATH" ]; do sleep 0.05; done
            nvim --server "$SESSION_PATH" --remote-ui
        else
            nvim --server "$CMD" --remote-ui
        fi
      '';
    };

in symlinkJoin {
  name = "nvim"; #so standard nvim is what you get with `nix run`
  paths = [ neovim neovimSession ];
}

# References:

# https://github.com/xnix-community/kickstart-nix.nvim/blob/main/nix/mkNeovim.nix
