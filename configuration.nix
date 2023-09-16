{ config, pkgs, ... }:

{
  imports = 
    [ 
      ./hardware-configuration.nix 
    ];
  
  # nix flakes
  nix.settings.experimental-features = [ "nix-command", "flakes" ];

  # bootloader
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
    };
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # networking
  networking = { 
    networkmanager.enable = true;
    hostName = "NixSama";
  };

  # locals
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # sway 
  # programs.sway.enable = true;
  security.polkit.enable = true;

  # audio
  sound.enable = true; 
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio = true;

  # user configuration
  users.users = {
    spamdoodler = {
      createHome = true;
      isNormalUser = true;
      extraGroup = [
        "wheel"
      ];
    };
  };

  in 
  {
    environment.systemPackages = with pkgs; [
      alacritty
      git
      neovim
      wget
      curl      
    ];
  };
  environment.variables.EDITOR = "nvim";  
}
