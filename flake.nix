{
  description = "Like diff but for Postgres schemas";

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
          rec {
            packages.migra = pkgs.poetry2nix.mkPoetryApplication {
              projectDir = ./.;
              overrides = pkgs.poetry2nix.overrides.withDefaults (
                self: super: {
                  tomli = super.tomli.overridePythonAttrs (
                    old: {
                      buildInputs = [
                        pkgs.python39Packages.flit-core
                      ];
                    }
                  );
                }
              );
            };

            defaultPackage = packages.migra;
          }
    );
}
