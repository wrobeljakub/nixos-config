{ config, pkgs, ... }:
{  
  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        version = 2;
      };
    };
  };
  
  # Machine specific networking settings
  networking = {
    hostName = "thonkpad";
    firewall.allowedUDPPorts = [ ];
    firewall.allowedTCPPorts = [ ];
    networkmanager.enable = true;
  };
  
  # Machine specific Xorg settings, mainly drivers
  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
  };
}
