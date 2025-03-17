{pkgs ? import <nixpkgs> {
  config.allowUnfree = true;
}}:

pkgs.mkShell rec {
  buildInputs = with pkgs; [
    udev
    alsa-lib
    mono
    dotnet-sdk
    stdenv
    clang_18
    icu
    openssl
    zlib
    SDL2
    SDL2.dev
    SDL2 SDL2_image SDL2_ttf SDL2_mixer
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    glib
    glibc
    libgcc
    libxkbcommon
    nss
    nspr
    atk
    mesa
    dbus
    pango
    cairo
    libpulseaudio
    libGL
    expat
    libdrm
    freetype
    fontconfig
    libglvnd
    pipewire
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    xorg.libICE
    xorg.libSM
    wayland
    wayland.dev
    wayland-scanner
    wayland-utils
    egl-wayland
    libexecinfo
    eudev
    python311Full
    embree2
    openusd
    autoPatchelfHook
    toybox
  ];

  NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
  NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";

  shellHook = ''
    
  '';
}
