{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./anyrun
    ./browsers/chromium.nix
    #./browsers/firefox
    ./browsers/zen.nix
    # ./kde
    ./media
    ./gtk.nix
    ./office
    ./qt.nix
    # ./ulauncher
  ];

  home.packages = with pkgs; [
    halloy
    tdesktop

    gnome-calculator
    gnome-control-center

    overskride
    resources
    wineWowPackages.wayland

    zotero

    # Quickshell stuff
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
  ];
}
