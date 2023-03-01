{ system ? "x86_64-linux", pkgs ? import <nixpkgs> { system = "x86_64-darwin"; } }:
let
  website = pkgs.haskellPackages.callPackage ./website.nix { nixpkgs = pkgs; };
in
  website.server
