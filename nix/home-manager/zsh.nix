{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autocd = true;
    history.size = 50000;
    history.save = 50000;

    initExtraFirst = builtins.readFile ./init-extra-first.zsh;
    initExtra = builtins.readFile ./init-extra.zsh;

    shellAliases = import ./aliases.nix;

    sessionVariables = {
      LESS = "-R -F -X";
      FZF_BASE= "${pkgs.fzf}/share/fzf";
    };

    plugins = [
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        # https://github.com/romkatv/powerlevel10k
        src = pkgs.fetchFromGitHub {
          owner  = "romkatv";
          repo   = "powerlevel10k";
          rev    = "d28e84ca7061c43c49c91059d15b49bc5859a3a7";
          sha256 = "1i4saf5k3kmsz36wdyg03lhfa910fb0iabxmf9rayaxd59f0z10p";
        };
      }
      {
        name = "autopair";
        # https://github.com/hlissner/zsh-autopair
        src = pkgs.fetchFromGitHub {
          owner  = "hlissner";
          repo   = "zsh-autopair";
          rev    = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "fzf-fasd";
        # https://github.com/wookayin/fzf-fasd
        src = pkgs.fetchFromGitHub {
          owner  = "wookayin";
          repo   = "fzf-fasd";
          rev    = "5552cdc6316ecd440a791175b8d3b1661d3dc2d7";
          sha256 = "1qvakkgjyrsz5jwyy7x7w5agbj0rrw5i1fb2rzhja5nqlkgjahk7";
        };
      }
      {
        name = "fzf-tab";
        # https://github.com/Aloxaf/fzf-tab
        src = pkgs.fetchFromGitHub {
          owner  = "Aloxaf";
          repo   = "fzf-tab";
          rev    = "23377e74c3780a1d4807a821df4011d3c793e69c";
          sha256 = "1fnn62qp9404z4qypx834h3464xij4wmhjrcgky87m3dr3f688yg";
        };
      }
      {
        name = "nix-shell";
        # https://github.com/chisui/zsh-nix-shell
        src = pkgs.fetchFromGitHub {
          owner  = "chisui";
          repo   = "zsh-nix-shell";
          rev    = "b6ac21e77d6d8e48f6ac08842345c8c9cd3460d5";
          sha256 = "166cgdfn53vq9bjg6589zwhiqayfymq8zvvrd94ps4sv78w3v3wn";
        };
      }
      # Note: this is already imported by 'programs.zsh.enableCompletion', which uses 'pkgs.nix-zsh-completions'
      # {
      #   name = "nix-zsh-completions";
      #   # https://github.com/spwhitt/nix-zsh-completions
      #   src = pkgs.fetchFromGitHub {
      #     owner  = "spwhitt";
      #     repo   = "nix-zsh-completions";
      #     rev    = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
      #     sha256 = "16r0l7c1jp492977p8k6fcw2jgp6r43r85p6n3n1a53ym7kjhs2d";
      #   };
      # }
      {
        name = "poetry";
        # https://github.com/darvid/zsh-poetry
        src = pkgs.fetchFromGitHub {
          owner  = "darvid";
          repo   = "zsh-poetry";
          rev    = "94e03cdf63789a54efebfb42c5291313603c0b1a";
          sha256 = "1fiayv3m0k7dyv4n72j7gfa4jja1byajz2aywxvcm38wls05mmh2";
        };
      }
      {
        name = "you-should-use";
        # https://github.com/MichaelAquilina/zsh-you-should-use
        src = pkgs.fetchFromGitHub {
          owner  = "MichaelAquilina";
          repo   = "zsh-you-should-use";
          rev    = "b4aec740f23d195116d1fddec91d67b5e9c2c5c7";
          sha256 = "0bq15d6jk750cdbbjfdmdijp644d1pn2z80pk1r1cld6qqjnsaaq";
        };
      }
      {
        name = "zsh-autosuggestions";
        # https://github.com/zsh-users/zsh-autosuggestions
        src = pkgs.fetchFromGitHub {
          owner  = "zsh-users";
          repo   = "zsh-autosuggestions";
          rev    = "ae315ded4dba10685dbbafbfa2ff3c1aefeb490d";
          sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
        };
      }

      # should be last
      {
        name = "fast-syntax-highlighting";
        # https://github.com/zdharma/fast-syntax-highlighting
        src = pkgs.fetchFromGitHub {
          owner  = "zdharma";
          repo   = "fast-syntax-highlighting";
          rev    = "a62d721affc771de2c78201d868d80668a84c1e1";
          sha256 = "0kwrkxkgsx9cchdrp9jg3p47y6h9w6dgv6zqapzczmx7slgmf4p3";
        };
      }
      {
        name = "zsh-completions";
        # https://github.com/zsh-users/zsh-completions
        src = pkgs.fetchFromGitHub {
          owner  = "zsh-users";
          repo   = "zsh-completions";
          rev    = "aa98bc593fee3fbdaf1acedc42a142f3c4134079";
          sha256 = "11q3f3nm0b13xhim5r3h2vpf76g97w811f30kl0a3w5i57jkc5vq";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh-custom";
      extraConfig = builtins.readFile ./extra-config.zsh;

      plugins = [
        "asdf"
        "colored-man-pages"
        "fasd"
        "fzf"
        "git"
        "gitfast"
        "github"
        "history"
        "man"
        "sudo"
        "virtualenv"
        "zsh-interactive-cd"
      ];
    };
  };

  home.file.".p10k.zsh".source = ./p10k.zsh;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
