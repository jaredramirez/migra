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
            packages.migra = import ./default.nix { inherit pkgs; };
            defaultPackage = packages.migra;
          }
    );
}
