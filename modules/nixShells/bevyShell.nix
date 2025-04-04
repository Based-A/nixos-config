{
  pkgs ? import <nixpkgs> { },
}:
mkShell rec {
  nativeBuildInputs = [
    cargo
    rustc
    rustPlatform.bindgenHook
    pkg-config
  ];
  buildInputs = [
    udev
    alsa-lib
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    libxkbcommon
    wayland
  ];
}
