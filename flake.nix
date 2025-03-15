{
  description = "Nixos config flake";

  # use `nix flake metadata` to see duplicated sources
  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    #   home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs-unstable";

    impermanence.url = "github:nix-community/impermanence";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # for comma index
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    inputs@{
      nixpkgs-unstable,
      nixpkgs-stable,
      ...
    }:
    let
      vars = {
      };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        #==================================================
        pie = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              pkgs-unstable
              pkgs-stable
              vars
              ;
          };
          modules = [ ./configuration.nix ];
        };
      };
    };
}
