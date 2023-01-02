{ system ? "x86_64-linux", pkgs ? import <nixpkgs> { system = "x86_64-darwin"; } }:
let
  website = pkgs.haskellPackages.callPackage ./website.nix {};
in
  pkgs.dockerTools.buildImage {
    name = "hello-docker";
    config = {
      Cmd = [ "${website.server}" ];
      Env = [
        "HTMLPATH=${website.client}"
        "PRODUCTION=1"
        ];
    };
  }
