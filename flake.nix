{
  description = "Nixos config flake";

  # use `nix flake metadata` to see duplicated sources
  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
  };
  outputs =
    inputs@{
      self,
      nixpkgs-stable,
      raspberry-pi-nix,
      ...
    }:
    let
      pkgs-stable = import inputs.nixpkgs-stable {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        # generate sd card image: `nix  --experimental-features 'nix-command flakes' build '.#nixosConfigurations.pie.config.system.build.sdImage' --out-link ~/Downloads/`
        pie = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              pkgs-stable
              ;
          };
          modules = [
            ./configuration.nix
            raspberry-pi-nix.nixosModules.raspberry-pi
            raspberry-pi-nix.nixosModules.sd-image
          ];
        };
      };
    };
}
