{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{

  options = {

    nvidia-graphics.enable = lib.mkEnableOption "enables nvidia graphics";
  };

  config = lib.mkIf config.nvidia-graphics.enable {

    hardware.graphics = {

      enable = true;
      package = config.hardware.nvidia.package;
      extraPackages = [ pkgs.mesa.drivers ];
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {

      modesetting.enable = true;

      powerManagement.enable = false;

      powerManagement.finegrained = false;

      nvidiaSettings = true;

      open = true;

      #package = config.boot.kernelPackages.nvidiaPackages.production;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    hardware.nvidia-container-toolkit.enable = true;

    environment.systemPackages = with pkgs; [
      cudaPackages.cudatoolkit
      nvidia-container-toolkit
    ];
  };
}
