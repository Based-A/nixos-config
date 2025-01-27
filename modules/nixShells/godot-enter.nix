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


  #PATH = "${pkgs.llvmPackages_19.libcxx}/bin:${pkgs.libgccjit}/bin:${pkgs.llvmPackages_19.clangUseLLVM}/bin";
  #LINK=${pkgs.mold}/lib/mold/mold-wrapper.so CXX=${pkgs.gcc}/bin/g++
  #patchelf --add-needed ${pkgs.wayland}
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
    cd /home/adam/Godot_4.4_dev/godot/bin
    ./godot.linuxbsd.editor.dev.x86_64
    
  '';
}