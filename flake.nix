{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    { } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        app = pkgs.bundlerEnv {
          name = "fyodor";
          ruby = pkgs.ruby;
          gemdir = ./.;
        };
      in
      {
        devShell = with pkgs; mkShell {
          name = "fyodor shell";
          buildInputs = [app bundix ruby];
        };
        defaultApp = app;
      });
}
