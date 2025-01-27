{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Local Users
  users.users = {
    adam = {
      isNormalUser = true;
      description = "adam";
      uid = 1000;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
    guest = {
      isNormalUser = true;
      description = "guest profile";
      uid = 1001;
    };
  };
}