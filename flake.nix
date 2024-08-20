{
  description = "styled-ppx";

  inputs = {
    nixpkgs = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.flake-utils.follows = "flake-utils";
    };

    ocaml-overlay = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    quickjs = {
      type = "git";
      url = "https://github.com/ml-in-barcelona/quickjs.ml.git";
      submodules = true;
      flake = false;
    };

    server-reason-react = {
      url = "github:ml-in-barcelona/server-reason-react";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        version = "0.59.2+dev";
        pkgs = nixpkgs.legacyPackages."${system}".extend (
          self: super: {
            ocaml = super.ocaml-ng.ocamlPackages_5_1;
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_1;
            # .overrideScope (
            #   oself: osuper: { ppxlib = osuper.ppxlib.override ({ version = "0.32.1"; }); }
            # );
          }
        );
        inherit (pkgs) ocamlPackages mkShell;
        inherit (ocamlPackages) buildDunePackage;

        quickjs = buildDunePackage {
          pname = "quickjs";
          version = "";
          propagatedBuildInputs = with ocamlPackages; [
            dune_3
            ocaml
            integers
            ctypes
          ];
          src = inputs.quickjs;
        };

        server-reason-react = buildDunePackage {
          pname = "server-reason-react";
          version = "";
          nativeBuildInputs = with ocamlPackages; [
            reason
            melange
          ];
          propagatedBuildInputs = with ocamlPackages; [
            dune_3
            ocaml
            ppxlib
            melange
            quickjs
            lwt
            lwt_ppx
            integers
            uri
          ];
          src = inputs.server-reason-react;
        };
      in
      {
        devShells = {
          default = mkShell.override { stdenv = pkgs.clang18Stdenv; } {
            buildInputs = with ocamlPackages; [
              dune_3
              ocaml
              utop
              ocamlformat
            ];
            inputsFrom = [ self.packages."${system}".default ];
            packages = builtins.attrValues {
              inherit (pkgs) clang_18 clang-tools_18 pkg-config;
              inherit (ocamlPackages) ocaml-lsp ocamlformat-rpc-lib;
            };
          };
        };
        packages = {
          default = buildDunePackage {
            inherit version;
            pname = "styled-ppx";
            nativeBuildInputs = with ocamlPackages; [ ];
            propagatedBuildInputs = with ocamlPackages; [
              alcotest
              dune_3
              fmt
              melange
              menhir
              ocaml
              ppx_deriving
              ppx_deriving_yojson
              ppxlib
              reason
              reason-react
              reason-react-ppx
              sedlex
              server-reason-react
              yojson
            ];
            src = ./.;
          };
        };
        formatter = pkgs.alejandra;
      }
    );
}
