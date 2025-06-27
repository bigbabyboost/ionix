{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./powersave.nix
    ./disko.nix
  ];

  boot = {
    kernelModules = ["i2c-dev"];
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelParams = [
      "amd_pstate=active"
      "ideapad_laptop.allow_v4_dytc=Y"
      ''acpi_osi="Windows 2020"''
    ];
  };

  # nh default flake
  environment.variables.NH_FLAKE = "/home/xaolan/Documents/code/dotfiles";

  hardware = {
    # xpadneo.enable = true;
    sensor.iio.enable = true;
  };

  networking.hostName = "ionia";

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;
  };
}
