# Main NixOS Configuration file

{ config, pkgs, ... }:
  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include machine specific configuration.
      ./machines/t460.nix
      # Include an Xorg configuration
      ./desktops.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Hardware
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport = true;
  };

  # Networking
  networking = {
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
  };
  
  # Timezone  
  time.timeZone = "Europe/Warsaw";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  # Sound
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  
  # User accounts
  users.users.jakubwrobel = {
    isNormalUser = true;
    home = "/home/jakubwrobel";
    description = "Jakub Wróbel";
    extraGroups = [ "wheel" "networkmanager" "docker"]; 
  };
  
  # Sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };  

  # Time
  services.timesyncd = {
    enable = true;
    servers = [ "pl.pool.ntp.org" ];
  };

  # Virtualization / other os's support
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest.enable = false;
  };
   users.extraGroups.vboxusers.members = [ "jakubwrobel" ];
  
  virtualisation.docker = {
    enable = true;
  };
  
  # Basic packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    zip
    unzip
    htop
    coreutils
    killall
    usbutils
    ntfs3g
    acpilight
    elinks
    xterm
  ];
  
  # Services
  services = {
      printing.enable = true;
  };
  
  # Nix config
  nix = {
    autoOptimiseStore = true;

    # Automate garbage collection
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';

    # Required by Cachix to be used as non-root user
    trustedUsers = [ "root" "jakubwrobel" ];
  };



  system.stateVersion = "21.03"; 

}

