{ system ? "x86_64-linux", pkgs ? import <nixpkgs> { system = "aarch64-darwin"; } }:
let
  website = pkgs.haskellPackages.callPackage ./website.nix {};
in
  pkgs.dockerTools.buildImage {
    name = "hello-docker";
    config = {
      Cmd = [ "${website.server}" ];
      Env = [
        "HTMLFILE=${website.client}"
        "PRODUCTION=1"
        ];
    };
  }
