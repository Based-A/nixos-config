{
  inputs,
  config,
  pkgs,
  lib,
  user,
  ...
}:

{
  imports = [
    ./../../modules/home-manager
  ];

  home = {
    username = "${user}";
    homeDirectory = lib.mkDefault "/home/${user}";
    stateVersion = "24.05"; # Please read the comment before changing.

    home.packages = with pkgs; [

    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
