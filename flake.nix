{
  description = "My personal website";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    rec {
      website = pkgs.callPackage ./website.nix { };
      packages.app = website.server;
      defaultPackage = packages.app;

      flyConfigs = import ./fly.nix;

      apps =
        let
          deployers = nixpkgs.lib.mapAttrs'
            (name: config:
              nixpkgs.lib.nameValuePair "deploy-${name}"
                (flake-utils.lib.mkApp {
                  drv = pkgs.writeShellScriptBin "deploy-${name}" ''
                    set -euxo pipefail
                    export PATH="${nixpkgs.lib.makeBinPath [(pkgs.docker.override { clientOnly = true; }) pkgs.flyctl]}:$PATH"
                    archive=${self.defaultDockerContainer.x86_64-linux}
                    config=${(pkgs.formats.toml {}).generate "fly.toml" config}
                    image=$(docker load < $archive | awk '{ print $3; }')
                    flyctl deploy -c $config -i $image
                  '';
                }))
            flyConfigs;
        in
        {
          app = flake-utils.lib.mkApp {
            drv = packages.app;
          };
        } // deployers;
      defaultApp = apps.app;

      dockerContainers.app = pkgs.dockerTools.buildLayeredImage {
        name = "app";
        contents = [
          packages.app
        ];
        config = {
          Cmd = [
            apps.app.program
          ];
          Env = [
            "HTMLFILE=${website.client}"
            "PRODUCTION=1"
          ];
          ExposedPorts = {
            "8080/tcp" = { };
          };
        };
      };
      defaultDockerContainer = dockerContainers.app;

      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.flyctl
        ];
      };

      hydraJobs = {
        inherit dockerContainers packages;
      };
    });
}
