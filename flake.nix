# /etc/nixos/flake.nix

{
  description = "flake for NixSama";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      NixSama = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };

  # wayland 
  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4"; # Super key
      output = { 
        "Virtual-1" = {
          mode = "1920x1080@60Hz";
        };
      };
    };
  };
  home.stateVersion = "23.11"
}
