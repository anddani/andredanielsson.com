{ nixpkgs }:
with nixpkgs;
let
  # Workaround for https://github.com/haskell-servant/servant/pull/1629
  hpkgs = haskellPackages.override {
    overrides = self: super: with haskell.lib; {
      servant-elm = dontCheck super.servant-elm;
    };
  };
  server = haskell.lib.justStaticExecutables
    ( hpkgs.callPackage ./server.nix rec {} );

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
