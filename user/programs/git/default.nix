{ config, pkgs, ... }:

let
  gitConfig = {
  };
in
{
  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    userEmail = "v40501814+wrobeljakub@users.noreply.github.com";
    userName = "Jakub Wróbel";
  };
}
