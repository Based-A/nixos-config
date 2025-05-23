{pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pkg-config
    autoPatchelfHook
  ];
  packages = with pkgs; [
    alsa-lib
    freetype
    fontconfig
    libGL
    libglvnd
    libpulseaudio
    libxkbcommon
    mesa
    pipewire
    vulkan-loader
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
    wayland
    wayland.dev
    wayland-scanner
    wayland-utils
    egl-wayland
    libexecinfo
    eudev
    python3
    # Compiling
    scons
    gcc
    mold
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    alsa-lib
    freetype
    fontconfig
    libGL
    libglvnd
    libpulseaudio
    libxkbcommon
    mesa
    pipewire
    vulkan-loader
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
    wayland
    wayland.dev
    wayland-scanner
    wayland-utils
    egl-wayland
    libexecinfo
    eudev
    python3
  ]);

  shellHook = ''
    scons platform=linuxbsd dev_build=yes dev_mode=yes linker=mold udev=yes
  '';
}