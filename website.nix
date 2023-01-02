{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;
let
  server = haskell.lib.justStaticExecutables
    ( haskellPackages.callPackage ./server.nix rec {} );

  client = import ./client/default.nix { nixpkgs = nixpkgs; };
  staticDirectory = ./client/static;

  env = stdenv.mkDerivation rec {
    name = "website-env";
    env = buildEnv { name = name; paths = buildInputs; };
    buildInputs = [
      zlib
      elm2nix
      elmPackages.elm
      elmPackages.elm-format
      cabal-install
    ];
  };
in
  { inherit server client env; }
