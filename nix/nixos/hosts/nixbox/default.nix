{ config, pkgs, ... }:

with builtins;
let
  fullname = "User Name";
  username = "username";
  hostname = "nixbox";

in
{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/common.nix
  ];

  boot = {
    # GRUB
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };

    # TODO: fuse, tmpOnTmpfs
  };

  hardware = {
    # PulseAudio
    pulseaudio.enable = true;

    # Bluetooth
    bluetooth.enable = true;
  };

  services = {
    # CUPS
    printing.enable = true;

    # Avahi
    avahi = {
      enable = true;
      nssmdns = true;
    };
  };

  networking = {
    hostName = hostname;
    interfaces.enp0s3.useDHCP = true;
  };

  nix = {
    # Auto-optimize nix store
    autoOptimiseStore = true;

    # Trusted users
    trustedUsers = [ "root" username "@wheel" ];

    # Free up to 1GiB whenever there is less than 100MiB left
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1 * 1024 * 1024 * 1024)}
    '';
  };

  # Setup main user account.
  users.users.${username} = {
    description = fullname;
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "vboxsf" "wheel" ];
  };

  # Setup home-manager.
  home-manager.users.${username} = import ./home-manager.nix;

  # Setup GNOME.
  services.xserver = {
    enable = true;
    desktopManager.gnome3 = { enable = true; };
    displayManager = {
      gdm.enable = true;
      # autoLogin.enable = true;
      # autoLogin.user = username;
    };
  };

  # Setup DBus for GNOME.
  services.dbus.packages = with pkgs; [ gnome3.dconf ];
  programs.dconf.enable = true;

  # ============================
  system.stateVersion = "20.09";
}
