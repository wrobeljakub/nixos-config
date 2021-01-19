{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      
      # Input
      layout = "pl";
      libinput = {
        enable = true;
        disableWhileTyping = true;
      };
      xkbOptions = ""; # Remap keys
  
      # Window managers / Desktop enviroments
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
