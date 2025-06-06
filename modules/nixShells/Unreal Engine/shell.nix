{pkgs ? import <nixpkgs> {
  config.allowUnfree = true;
}}:
# nix-alien-ld -p udev -p alsa-lib -p mono -p dotnet-sdk -p stdenv -p stdenv.cc.cc.lib -p clang_18 -p icu -p openssl -p zlib -p SDL2 -p SDL2.dev -p SDL2 -p SDL2_image -p SDL2_ttf -p SDL2_mixer -p vulkan-loader -p vulkan-tools -p vulkan-validation-layers -p glib -p glibc -p libgcc -p libxkbcommon -p nss -p nspr -p atk -p mesa -p dbus -p pango -p cairo -p libpulseaudio -p libGL -p expat -p libdrm -p freetype -p fontconfig -p libglvnd -p pipewire -p wayland -p wayland.dev -p wayland-scanner -p wayland-utils -p egl-wayland -p libexecinfo -p eudev -p python311Full -p embree2 -p openusd -p xorg.libX11 -p xorg.libXScrnSaver -p xorg.libXcomposite -p xorg.libXcursor -p xorg.libXdamage -p xorg.libXext -p xorg.libXfixes -p xorg.libXi -p xorg.libXrandr -p xorg.libXrender -p xorg.libXtst -p xorg.libxcb -p xorg.libxkbfile -p xorg.libxshmfence -p xorg.libICE -p xorg.libSM Engine/Binaries/Linux/UnrealEditor
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    udev
    alsa-lib
    mono
    dotnet-sdk
    stdenv
    stdenv.cc.cc.lib
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
