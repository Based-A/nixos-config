{
  pkgs,
  inputs,
  lib,
  config,
  user,
  ...
}:
{
  options = {
    docker.enable = lib.mkEnableOption "enables docker virtualization service";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.containers.enable = true;
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";

      rootless = {
        enable = true;
        setSocketVariable = true;
      };

      daemon.settings = {
        data-root = "/home/${user}/Docker";
      };
    };

    users.users.${user}.extraGroups = [ "docker" ];
  };
}
