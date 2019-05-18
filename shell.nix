{ pkgs ? (import <nixpkgs> {}) }:
let
  boolector-sys = { rustPlatform, llvmPackages, boolector, gcc7, glibc, pkgconfig }:
  rustPlatform.buildRustPackage rec {
    name = "boolector-sys-${version}";
    version = "0.1.2";
    src = ./.;
    cargoSha256 = "1h6xdydxbvl90jz7k6sdgwbjvc53x9l5cm952h8p1kvdiwagrgj3";

nativeBuildInputs = [ pkgconfig ];
    buildInputs = [ boolector gcc7 glibc ];
    BINDGEN_CFLAGS_COMPILE = [
      "-I${boolector.dev}/include"
      "-I${llvmPackages.libclang.out}/lib/clang/7.1.0/include"
      "-I${glibc.dev}/include"
    ];

    # Needed so bindgen can find libclang.so
    LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
  };
  drv = pkgs.callPackage boolector-sys {};
in drv
