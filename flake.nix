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

        tmuxConf = pkgs.writeText "tmux.conf" ''
          set -g prefix M-Space
          unbind M-Space
          bind -n M-Space send-prefix

          set -g mouse on

          # With shift
          bind-key "|" split-window -h -c "#{pane_current_path}"
          bind-key "\\" split-window -fh -c "#{pane_current_path}"
          # Without shift
          bind-key "-" split-window -v -c "#{pane_current_path}"
          bind-key "_" split-window -fv -c "#{pane_current_path}"

          bind-key o display-popup -E ${pkgs.fish}/bin/fish -N -c "tmux ls | cut -d':' -f1 | ${pkgs.fzf}/bin/fzf | xargs tmux switch-client -t"

          setw -g mode-keys vi

          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"

          set -g @resurrect-strategy-nvim 'session'
          set -g @continuum-restore 'on'

          set -gq allow-passthrough on

          set-option -g default-shell ${pkgs.fish}/bin/fish

          # Plugins
          run-shell '${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux'
          run-shell '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux'
          run-shell '${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux'
        '';

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
            
            # Configure tmux to use the nix-generated config
            alias tmux="tmux -f ${tmuxConf}"

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

