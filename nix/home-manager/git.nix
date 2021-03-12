{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    # package = pkgs.gitFull;

    userName = "Konstantin Chukharev";
    userEmail = "lipen00@gmail.com";

    aliases = {
      co = "checkout";
      st = "status";
      lg = "log --graph --abbrev-commit --pretty=format:\"%C(auto)%h -%d %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\"";
      commend = "commit --amend --no-edit";
      unstage = "reset HEAD";
      tags = "tag -l";
      remotes = "remote -v";
      stash-unapply = "!git stash show -p | git apply -R";
    };

    signing = {
      key = "D0EF616F416E8333";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Monokai Extended Bright";
        decorations = {
          file-style="bold brightblue ul";
          file-decoration-style = "none";
          hunk-header-style = "omit";
        };
      };
    };

    extraConfig = {
      branch = {
        autoSetupMerge = "always";
        autoSetupRebase = "always";
      };

      fetch = { prune = "true"; };
      pull = { rebase = "true"; };
      push = {
        default = "current";
        followTags = "true";
      };

      rebase = {
        autoSquash = "true";
        autoStash = "true";
      };

      merge = {
        ff = "only";
        log = "true";
        conflictStyle = "diff3";
      };

      rerere = {
        enabled = "true";
        autoUpdate = "true";
      };

      url = {
        "https://github.com/" = { insteadOf = "gh:"; };
        "ssh://git@github.com/Lipen" = { insteadOf = "gh:lipen"; };
      };

      ghq = {
        root = "${config.home.homeDirectory}/src";
      };
    };
  };

  home.packages = with pkgs;[ gh ghq ];

  # Setup 'gh'
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        serverAliveInterval = 60;
        extraOptions = {
          ControlMaster = "auto";
          ControlPersist = "yes";
        };
      };
    };
  };
}
