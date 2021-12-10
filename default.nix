{ pkgs }:

pkgs.poetry2nix.mkPoetryApplication {
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
}
