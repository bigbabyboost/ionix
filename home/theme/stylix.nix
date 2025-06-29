{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  aporetic-nerd = inputs.self.packages.${pkgs.system}.aporetic-nerd-patch;
in {
  imports = [inputs.stylix.homeModules.stylix];

  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = config.theme.wallpaper;
    base16Scheme = ./kanagawa-dragon.yaml; # {
    # base00 = "242424"; # ----
    # base01 = "3c3836"; # ---
    # base02 = "504945"; # --
    # base03 = "665c54"; # -
    # base04 = "bdae93"; # +
    # base05 = "d5c4a1"; # ++
    # base06 = "ebdbb2"; # +++
    # base07 = "fbf1c7"; # ++++
    # base08 = "fb4934"; # red
    # base09 = "fe8019"; # orange
    # base0A = "fabd2f"; # yellow
    # base0B = "b8bb26"; # green
    # base0C = "8ec07c"; # aqua/cyan
    # base0D = "7daea3"; # blue
    # base0E = "e089a1"; # purple
    # base0F = "f28534"; # brown
    # };

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
        name = "AporeticSerifMono Nerd Font Propo";
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
