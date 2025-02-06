{
  pkgs,
  config,
  ...
}:
let
  package_ver = config.boot.kernelPackages.nvidiaPackages.production;
in
{
  hardware = {
    # Enable OpenGL
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
    };

    # Configure Nvidia driver
    nvidia = {
      modesetting.enable = true;
      datacenter.enable = false;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      package = package_ver;
    };

    # Enable nvidia container
    nvidia-container-toolkit.enable = true;
  };

  # Set xserver driver to nvidia
  services.xserver.drivers = [ "nvidia" ];

  # Nvidia and Cuda support
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.cudaSupport = true;
}
