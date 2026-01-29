{
  description = "Neovim devShell with Rust, Gleam, and common tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixvim, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Build the custom Neovim
        nixvimLib = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = import ./default.nix;
          extraSpecialArgs = { };
        };
        customNeovim = nixvimLib.makeNixvimWithModule nixvimModule;

      in
      {
        packages = {
          default = customNeovim;
        };

        devShells.default = pkgs.mkShell {
          name = "dev-shell";

          packages = with pkgs; [
            customNeovim
            git
            jujutsu
            tmux
            ripgrep
            fd
            fzf
            jq
            bat
            rustc
            cargo
            rust-analyzer
            rustfmt
            gleam
            erlang
            go
            gopls
            gotools
            golangci-lint
            python3
            pyright
            black
            bun
            nodePackages.typescript-language-server
            nodePackages.prettier
            nodePackages.eslint_d
            lua-language-server
            stylua
            opencode
            fish
          ];

          shellHook = ''
            # Setup environment variables
            # export PATH="${customNeovim}/bin:$PATH"
            export PATH="$PWD/bin:$PATH"

            export SHELL="${pkgs.fish}/bin/fish"
            
            echo "🚀 Loading Dev Shell..."

            # Exec into fish, configuring the prompt and alias on startup
            # -C runs commands after reading configuration
            exec ${pkgs.fish}/bin/fish -C "
              function fish_right_prompt
                set_color cyan
                echo '❄️  dev-shell '
                set_color normal
              end
            "
          '';
        };
      });
}

