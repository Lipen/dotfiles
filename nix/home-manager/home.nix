{ config, pkgs, ... }:

let
  comma = import
    (pkgs.fetchFromGitHub {
      owner = "Shopify";
      repo = "comma";
      rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
      sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
    })
    { inherit pkgs; };

in
{
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.stateVersion = "20.09";
  # home.username = "$USER";
  # home.homeDirectory = "$HOME";

  home.packages = with pkgs; [
    ## CLI tools
    ag
    atool
    bat
    colordiff
    # coreutils  # replaces by 'uutils-coreutils'
    cowsay
    curl
    exa
    fasd
    fd
    ffmpeg
    file
    fortune
    htop
    iotop
    jq
    loc
    ncdu
    nnn
    parallel
    ripgrep
    tldr
    tree
    unzip
    uutils-coreutils
    wget
    xclip
    zip

    ## Nix
    update-nix-fetchgit

    ## Apps
    chromium
    firefox
    tdesktop

    ## Media
    sublime3
    mpv
    vlc
    evince
    okular
    # pdfsam-basic

    ## WM
    gnome3.gnome-tweaks
    wofi

    ## Fonts
    jetbrains-mono
    (nerdfonts.override {
      fonts = [
        "DroidSansMono"
        "FiraCode"
        "Hack"
        "JetBrainsMono"
        "Meslo"
        "SourceCodePro"
      ];
    })

    ## Custom packages
    comma
  ];

  # Evironment
  home.sessionVariables = {
    VISUAL = "subl";
    PATH = "$HOME/bin:$HOME/.cargo/bin:$PATH";
    # NIX_PATH = "$HOME/.nix-defexpr/channels$\{NIX_PATH:+:}$NIX_PATH";
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
    };
  };

  # Fontconfig
  # fonts.fontconfig.enable = true;

  # home-manager
  programs.home-manager.enable = true;

  # XDG
  xdg = {
    enable = true;
    # mimeApps = {
    #   enable = true;
    #   associations.added = {
    #     "text/plain" = "sublime_text.desktop;org.gnome.gedit.desktop";
    #     "application/pdf" = "okularApplication_pdf.desktop";
    #   };
    #   defaultAppications = {
    #     "text/html"="firefox.desktop";
    #   };
    # };
  };

  # Gpg
  programs.gpg = {
    enable = true;
  };

  # Redshift
  services.redshift = {
    enable = true;
    latitude = "60";
    longitude = "30";
    temperature = {
      night = 3000;
      day = 5000;
    };
  };
}
