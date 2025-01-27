{
  pkgs,
  lib,
  config,
  input,
  user,
  host,
  ...
}:
{

  options = {

    sops-nix.enable = lib.mkEnableOption "enables secrets management using sops-nix";
  };

  config = lib.mkIf config.sops-nix.enable {
      sops = {
        defaultSopsFile = ./../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
      };
  };
}
