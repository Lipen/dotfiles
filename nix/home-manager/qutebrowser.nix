{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    qutebrowser
    # For Brave adblock in qutebrowser, which is significantly better than the
    # built-in host blocking. Works on youtube and crunchyroll ads!
    python39Packages.adblock
  ];

  xdg.configFile = {
    "qutebrowser/config.py".source = ./qutebrowser-config.py;
    # "qutebrowser/extra/00-extraConfig.py".text = cfg.extraConfig;
  };
  # xdg.dataFile = {
  #   "qutebrowser/userstyles.css".text = cfg.userStyles;
  # };

  # # Install language dictionaries for spellcheck backends
  # system.userActivationScripts.qutebrowserInstallDicts =
  #   concatStringsSep "\\\n" (map (lang: ''
  #     if ! find "$XDG_DATA_HOME/qutebrowser/qtwebengine_dictionaries" -type d -maxdepth 1 -name "${lang}*" 2>/dev/null | grep -q .; then
  #       ${pkgs.python3}/bin/python ${pkg}/share/qutebrowser/scripts/dictcli.py install ${lang}
  #     fi
  #   '') cfg.dicts);
}
