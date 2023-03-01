{ pkgs ? import <nixpkgs> {} }:
let
  website = pkgs.callPackage ./website.nix { nixpkgs = pkgs; };
in
  website.env
