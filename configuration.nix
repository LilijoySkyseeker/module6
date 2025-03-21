{ lib, pkgs-stable, ... }:
{
  # system packages
  environment.systemPackages = with pkgs-stable; [
    git
  ];

  # ssh server
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFA+HAQkhmPxKyJFSopziqIVNvFqEaqyRWPVvgu+urfh lilijoy@nixos-thinkpad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6pG0Y9QdCBRJZKpCD62U3uXl5Lz/bE0ifWLbhZ4q9o lilijoy@torrent"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJN4rgL2x8oJ0OwXw7q0prfLqg/QngE1yr80x2rrxJFQ curra@Desktop-Casey"
  ];
  services.openssh = {
    ports = [ 2222 22 ];
    openFirewall = true;
    allowSFTP = true;
    enable = true;
    settings.KbdInteractiveAuthentication = false;
    extraConfig = ''
      passwordAuthentication = no
      PermitRootLogin = prohibit-password
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
      PermitTunnel no
    '';
  };
  
  # security
  nix.settings.allowed-users = [ "root" ];
  security.sudo.enable = false;

  # auto garbage collection with nh
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 7d --keep 7";
    };
  };

  # neovim
  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkForce true;
  };

  # fix for buggy command not found
  programs.command-not-found.enable = false;

  # remove all defualt packages
  environment.defaultPackages = lib.mkForce [ ];

  # firewall
  networking.firewall.enable = true;

  # Enable Flake Support
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # set nixpkgs to arm
  nixpkgs.hostPlatform.system = "aarch64-linux";

  # set specific board for raspberry pi
  raspberry-pi-nix.board = "bcm2712"; # bcm2711 for rpi 3, 3+, 4, zero 2 w : bcm2712 for rpi 5

  # hostname
  networking.hostName = "pie";

  # timezone
  time.timeZone = "America/New_York";

  # first install state version, dont touch
  system.stateVersion = "24.11";
}
