{ pkgs, ... }:

{
  imports = [
    # ./console.nix
    ./programs/gnupg.nix
  ];

  environment.systemPackages = with pkgs;
    [
      # cacert
      # coreutils
    ];

  nix = {
    # Enable flakes and new CLI
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking = {
    networkmanager.enable = true;

    # Docs says that this flag is deprecated or something, so it just should be false
    useDHCP = false;
  };

  security = { sudo.enable = true; };

  services = {
    openssh.enable = true;
  };

  time.timeZone = "Europe/Moscow";

  custom = {
    shell = {
      enable = true;
      package = pkgs.zsh;
    };
  };
}
