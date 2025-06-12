{
  pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
  },
}:
# nix-alien-ld -p udev -p alsa-lib -p mono -p dotnet-sdk -p stdenv -p stdenv.cc.cc.lib -p clang_18 -p icu -p openssl -p zlib -p SDL2 -p SDL2.dev -p SDL2 -p SDL2_image -p SDL2_ttf -p SDL2_mixer -p vulkan-loader -p vulkan-tools -p vulkan-validation-layers -p glib -p glibc -p libgcc -p libxkbcommon -p nss -p nspr -p atk -p mesa -p dbus -p pango -p cairo -p libpulseaudio -p libGL -p expat -p libdrm -p freetype -p fontconfig -p libglvnd -p pipewire -p wayland -p wayland.dev -p wayland-scanner -p wayland-utils -p egl-wayland -p libexecinfo -p eudev -p python311Full -p embree2 -p openusd -p xorg.libX11 -p xorg.libXScrnSaver -p xorg.libXcomposite -p xorg.libXcursor -p xorg.libXdamage -p xorg.libXext -p xorg.libXfixes -p xorg.libXi -p xorg.libXrandr -p xorg.libXrender -p xorg.libXtst -p xorg.libxcb -p xorg.libxkbfile -p xorg.libxshmfence -p xorg.libICE -p xorg.libSM Engine/Binaries/Linux/UnrealEditor
let
  #stdenv = pkgs.llvmPackages_18.stdenv;
  dotnetPkg = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_9_0
    ]
  );
  packages =
    with pkgs;
    [
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
      SDL2
      SDL2_image
      SDL2_ttf
      SDL2_mixer
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      glib
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
      wayland
      embree2
      openusd
    ]
    ++ (with pkgs.xorg; [
      libICE
      libSM
      libX11
      libxcb
      libXcomposite
      libXcursor
      libXdamage
      libXext
      libXfixes
      libXi
      libXrandr
      libXrender
      libXScrnSaver
      libxshmfence
      libXtst
    ]);
in
pkgs.buildFHSEnv {
  name = "UE5";
  buildInputs = packages;

  NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
  #NIX_LD = "${stdenv.cc.libc_bin}/bin/ld.so";
  NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

  shellHook = ''
    DOTNET_ROOT="${dotnetPkg}";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1;

  '';
}
