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
    macOS = {
      isNormalUser = true;
      description = "macOS VM user";
      uid = 1002;
    };
    otto = {
      isNormalUser = true;
      description = "automation user profile";
      uid = 1003;
    };
  };
}