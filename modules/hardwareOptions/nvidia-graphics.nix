{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nvidia-graphics.enable = lib.mkEnableOption "enables nvidia graphics";
  };

  config = lib.mkIf config.nvidia-graphics.enable {
    hardware = {
      graphics = {
        enable = true;
        package = config.hardware.nvidia.package;
        extraPackages = [ pkgs.mesa ];
      };
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaSettings = true;
        open = true;
        #package = config.boot.kernelPackages.nvidiaPackages.production;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
      #nvidia-container-toolkit.enable = true;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = with pkgs; [
      cudaPackages.cudatoolkit
      nvidia-container-toolkit
    ];
    /*
      boot.extraModprobeConfig = ''
      options nvidia_modeset vblank_sem_control=0
      '';
    */
  };
}
