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
      hashedPasswordFile = config.sops.secrets.adamUserPassword.path;
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
      hashedPasswordFile = config.sops.secrets.macosVMUserPassword.path;
    };
    nixPi = {
      isNormalUser = true;
      description = "nixPi User";
      uid = 1003;
      hashedPasswordFile = config.sops.secrets.nixPi4UserPassword.path;
    };
    bigBoss = {
      isNormalUser = true;
      description = "Big Storage Server User";
      uid = 1004;
      hashedPasswordFile = config.sops.secrets.bigBossUserPassword.path;
    };
  };

  sops.secrets = {
    adamUserPassword.neededForUsers = true;
    macosVMUserPassword.neededForUsers = true;
    nixPi4UserPassword.neededForUsers = true;
    bigBossUserPassword.neededForUsers = true;
  };
}