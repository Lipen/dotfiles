{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    with builtins;
    let
      inherit (nixpkgs) lib;

      system = "x86_64-linux";

      mkPkgs = pkgs:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
          # overlays = inputOverlays ++ selfOverlays ++ extraOverlays;
        };

      pkgs = mkPkgs nixpkgs;

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
    in {
      nixosModules = importDirToAttrs ./nixos/modules;

      # homeManagerModules = importDirToAttrs ./home-manager/modules;

      nixosConfigurations = let
        hostsDir = ./nixos/hosts;
        hosts = attrNames (readDir hostsDir);
        mkHost = host:
          let
            baseNixosModule = {
              system.configurationRevision = lib.mkIf (self ? rev) self.rev;
              nixpkgs = { inherit pkgs; };
              nix.nixPath = [
                # "home-manager=${home-manager}"
                "nixpkgs=${nixpkgs}"
              ];
              nix.registry.nixpkgs.flake = nixpkgs;
            };
            homeNixosModule = {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
              };
            };
          in lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };

            modules = [
              baseNixosModule
              homeNixosModule
              { imports = [ (hostsDir + "/${host}") ]; }
            ];

            extraModules = [ home-manager.nixosModules.home-manager ]
              ++ (attrValues self.nixosModules);
          };
      in lib.genAttrs hosts mkHost;

      defaultPackage.x86_64-linux =
        self.nixosConfigurations.nixbox.config.system.build.toplevel;
    };
}
