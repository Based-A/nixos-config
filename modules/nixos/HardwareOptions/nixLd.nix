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
        # UE5 Libs
        ## Core
        dotnet-sdk
        mono
        clang_18
        llvmPackages_18.libcxxClang
        stdenv
        openssl
        glib
        glibc
        libgcc
        ## Utilities
        alsa-lib
        icu
        icu64
        zlib
        SDL2
        SDL2.dev
        SDL2 SDL2_image SDL2_ttf SDL2_mixer
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
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
        python311Full
        openusd
      ];
    };
  };
}
