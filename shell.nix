{ pkgs ? import <nixpkgs> {} }:
let
  website = pkgs.callPackage ./website.nix {};
in
  website.env
