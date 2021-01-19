#! /usr/bin/env bash

# Shows the output of every command
set +x
# Nix configuration
sudo cp -r system/* /etc/nixos/


# Home manager
mkdir -p $HOME/.config/nixpkgs/
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
cp -r user/* $HOME/.config/nixpkgs/

