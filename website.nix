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


  nodeEnv = import ./node-packages/node-env.nix {
    inherit (nixpkgs) stdenv lib python2 runCommand writeTextFile writeShellScript;
    pkgs = nixpkgs;
    inherit nodejs;
    libtool = if nixpkgs.stdenv.isDarwin then nixpkgs.darwin.cctools else null;
  };

  extraNodePackages = import ./node-packages/node-packages.nix {
    inherit (nixpkgs) fetchurl nix-gitignore stdenv lib fetchgit;
    inherit nodeEnv;
  };

  env = stdenv.mkDerivation rec {
    name = "website-env";
    env = buildEnv { name = name; paths = buildInputs; };
    shellHook = ''
      export PATH="$PWD/node_modules/.bin/:$PATH"
    #   export HTMLFILE=${client}
    #   export PRODUCTION=0
    #   echo "$HTMLFILE"
    #   ${server}/bin/website
    '';
    buildInputs = [
      zlib
      elm2nix
      elmPackages.elm
      elmPackages.elm-pages
      elmPackages.elm-format
      cabal-install
      nodejs
      nodePackages.npm
      extraNodePackages.fs-extra
    ];
  };
in
  { inherit server client env; }
