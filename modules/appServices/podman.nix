{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    podman.enable = lib.mkEnableOption "enables podman virtualization service";
  };

  config = lib.mkIf config.podman.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    users.users.adam.extraGroups = [ "podman" ];

    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
