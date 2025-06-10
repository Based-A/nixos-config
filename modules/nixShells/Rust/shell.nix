{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell rec {
  nativeBuildInputs = with pkgs; [
    cargo
    rustc
    rustPlatform.bindgenHook
    pkg-config
    zed-editor
  ];
  buildInputs = with pkgs; [
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
}
