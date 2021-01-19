{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    # fixes the `ar` error required by cabal
    binutils-unwrapped
    stow
  ];

  gitPkgs = with pkgs.gitAndTools; [
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    nix-tree                # visualize nix dependencies
  ];

  xmonadPkgs = with pkgs; [
    xorg.xkbcomp           # keymaps modifier
    xorg.xmodmap           # keymaps modifier
    xorg.xrandr            # display manager (X Resize and Rotate protocol)
  ];

in
{
  programs.home-manager.enable = true;

  imports = [
    ./programs/firefox/default.nix
    ./programs/xmonad/default.nix
    ./programs/alacritty/default.nix
    ./programs/git/default.nix
  ];

  xdg.enable = true;

  home = {
    username      = "jakubwrobel";
    homeDirectory = "/home/jakubwrobel";
    stateVersion  = "21.03";

    packages = defaultPkgs ++ gitPkgs ++ haskellPkgs ++ xmonadPkgs ;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "vim";
    };
  };

  manual = {
    json.enable = false;
    html.enable = false;
    manpages.enable = false;
  };

  # notifications about home-manager news
  news.display = "silent";

  #gtk = {
  #  enable = true;
  #  iconTheme = {
  #    name = "Adwaita-dark";
  #    package = pkgs.gnome3.adwaita-icon-theme;
  #  };
  #  theme = {
  #    name = "Adwaita-dark";
  #    package = pkgs.gnome3.adwaita-icon-theme;
  #  };
  #};
}
