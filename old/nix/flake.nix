{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nix.url = "github:NixOS/nix";
    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
    with builtins;
    let
      inherit (nixpkgs) lib;

      system = "x86_64-linux";

      pkgs =
        let
          # nixOverlay = final: prev: {
          #   nixUnstable = nix.defaultPackage.${system};
          # };
          overlays = [ nur.overlay ];
        in
        import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };

      kebabCaseToCamelCase =
        replaceStrings (map (s: "-${s}") lib.lowerChars) lib.upperChars;

      importDirToAttrs = dir:
        lib.pipe dir [
          lib.filesystem.listFilesRecursive
          (filter (lib.hasSuffix ".nix"))
          (map (path: {
            name = lib.pipe path [
              toString
              (lib.removePrefix "${toString dir}/")
              (lib.removeSuffix "/default.nix")
              (lib.removeSuffix ".nix")
              kebabCaseToCamelCase
              (replaceStrings [ "/" ] [ "-" ])
            ];
            value = import path;
          }))
          listToAttrs
        ];

      # homeManagerExtraModules = (attrValues self.homeManagerModules);
      # homeManagerExtraModules = [ (import ./home-manager/home.nix) ];
    in
    {
      nixosModules = importDirToAttrs ./nixos/modules;

      # homeManagerModules = importDirToAttrs ./home-manager/modules;

      nixosConfigurations =
        let
          hostsDir = ./nixos/hosts;
          hosts = attrNames (readDir hostsDir);
          mkSystem = host:
            let
              baseNixosModule = {
                system.configurationRevision = lib.mkIf (self ? rev) self.rev;
                nixpkgs = { inherit pkgs; };
                nix.nixPath =
                  [ "home-manager=${home-manager}" "nixpkgs=${nixpkgs}" ];
                nix.registry.nixpkgs.flake = nixpkgs;
              };
              homeNixosModule = {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "bak";
                };
              };
            in
            lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs; };

              modules = [
                (import (hostsDir + "/${host}"))
                baseNixosModule
                homeNixosModule
                home-manager.nixosModules.home-manager
              ];

              extraModules = (attrValues self.nixosModules);
            };
        in
        lib.genAttrs hosts mkSystem;

      homeConfigurations =
        let
          mkHome =
            { username, configuration, homeDirectory ? "/home/${username}" }:
            home-manager.lib.homeManagerConfiguration {
              inherit username homeDirectory system pkgs;

              # Without mysterious "extraSpecialArgs",
              #  'pkgs' are not being correctly passed to home-manager.
              extraSpecialArgs = { inherit pkgs; };

              configuration = {
                imports = [ configuration ];
                # targets.genericLinux.enable = pkgs.stdenv.hostPlatform.isLinux;
              };
            };
        in
        {
          username = mkHome {
            username = "username";
            configuration = {
              # profiles.graphical.enable = true;
              imports = [ ./home-manager/home.nix ];
              # nixpkgs.config.allowUnfree = true;
            };
          };
        };

      # Main nixosConfigurations
      nixbox = self.nixosConfigurations.nixbox.config.system.build.toplevel;

      # Main homeManagerConfiguration
      hm = self.homeConfigurations.username.activationPackage;

      # Default package for 'nix build .'
      defaultPackage.x86_64-linux = self.nixbox;
    };
}
