{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  aporetic-nerd = inputs.aporetic-nerd-patch.packages.${pkgs.system}.default;
in {
  imports = [inputs.stylix.homeModules.stylix];

  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = config.theme.wallpaper;
    base16Scheme = ./gruvbox-material-soft-dark.yaml;
    polarity = "dark";

    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons;
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
    };

    fonts = {
      sizes.applications = lib.mkDefault 10;
      sizes.terminal = lib.mkDefault 11;
      sizes.desktop = lib.mkDefault 10;
      serif = {
        package = aporetic-nerd;
        name = lib.mkDefault "AporeticSerif Nerd Font Propo";
      };
      sansSerif = {
        package = lib.mkDefault aporetic-nerd;
        name = lib.mkDefault "AporeticSans Nerd Font Propo";
      };
      monospace = {
        package = aporetic-nerd;
        name = "AporeticSerifMono Nerd Font";
      };
      emoji = {
        package = lib.mkDefault pkgs.noto-fonts-emoji;
        name = lib.mkDefault "Noto Color Emoji";
      };
    };

    cursor = {
      package = lib.mkDefault pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Modern-Ice";
      size = lib.mkDefault 18;
    };

    opacity = {
      terminal = 0.8;
      desktop = 1;
      applications = 0.85;
      popups = 0.9;
    };

    targets = {
      gnome-text-editor.enable = lib.mkDefault false;
      gtk.enable = true;
      gtk.flatpakSupport.enable = true;
      bat.enable = true;
      btop.enable = true;
      cava.enable = true;
      foot.enable = true;
      fzf.enable = true;
      ghostty.enable = true;
      hyprland.enable = false;
      hyprlock.enable = false;
      micro.enable = true;
      qt.enable = true;
      yazi.enable = true;
      zed.enable = false;
      waybar.enable = false;
      zathura.enable = false;
    };
  };
}
