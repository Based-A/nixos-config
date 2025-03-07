{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    nixLd.enable = lib.mkEnableOption "enables nix-ld to run unpatched dynamicaly linked binaries";
  };

  config = lib.mkIf config.nixLd.enable {
    programs.nix-ld = {
      enable = true;

      libraries = with pkgs; [
        udev
        alsa-lib
        mono
        dotnet-sdk
        stdenv
        clang_18
        icu
        openssl
        openssl_3
        openssl_legacy
        zlib
        SDL2
        SDL2.dev
        SDL2 SDL2_image SDL2_ttf SDL2_mixer
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
        glib
        glibc
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
        python3
        llvmPackages_20.libcxxClang
      ];
    };
  };
}
