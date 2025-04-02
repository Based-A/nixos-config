{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{

  options = {
    garageS3.enable = lib.mkEnableOption "enables garage s3 storage solution.";
  };

  config = lib.mkIf config.garageS3.enable {
    services.garage = {
      enable = true;
    };
  };
  /* TODO:
    Garage Vs Minio
    Setup Nginx proxy
    Setup Garage/Minio S3 Service
    Link in Obsidian Vault
    */
}
