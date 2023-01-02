{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;
let
  srcs = ./elm-srcs.nix;
  registryDat = ./registry.dat;
in stdenv.mkDerivation {
  name = "frontend.html";
  src = ./.;
  license = lib.licenses.mit.spdxId;

  buildInputs = [ elmPackages.elm ];

  buildPhase = elmPackages.fetchElmDeps {
    elmPackages = import srcs;
    elmVersion = "0.19.1";
    inherit registryDat;
  };

  installPhase = ''
    elm make src/Main.elm --output $out
  '';
}