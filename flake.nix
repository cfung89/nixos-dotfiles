{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Personal applications
    # go_tmux_sessionizer.url = "github:cfung89/go_tmux_sessionizer";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.Scorpius = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.cyrus = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
