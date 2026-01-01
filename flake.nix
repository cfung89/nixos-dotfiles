{
  description = "Multi-host NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs:
    let
      mkMachine = { hostname, system ? "x86_64-linux", isWSL ? false
        , extraModules ? [ ] }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs isWSL; };
          modules = [
            ./machines/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit isWSL; };
                users.cyrus = import ./machines/${hostname}/home.nix;
              };
            }
          ] ++ extraModules;
        };
    in {
      nixosConfigurations = {
        Scorpius = mkMachine { hostname = "Scorpius"; };
        Perseus = mkMachine {
          hostname = "Perseus";
          system = "aarch64-linux";
          isWSL = true;
          extraModules = [ inputs.nixos-wsl.nixosModules.default ];
        };
      };
    };
}
