{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell rec {
  nativeBuildInputs = with pkgs; [
    cargo
    rustc
    rustPlatform.bindgenHook
    pkg-config
  ];
  buildInputs = with pkgs; [
    udev
    alsa-lib
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    libxkbcommon
    wayland
    clang_20
    mold
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
  MOLD_LINKER = pkgs.mold;
}
