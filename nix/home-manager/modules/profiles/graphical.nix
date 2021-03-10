{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.graphical;
in {
  options = {
    enable = mkEnableOption "Graphical profile";
  };

  config = mkIf cfg.enable (mkMerge [
    # GTK
    {
      gtk.enable = true;
      # ...
    }
  ]);
}
