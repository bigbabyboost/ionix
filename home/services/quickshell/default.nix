{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  homeDir = config.home.homeDirectory;
  quickshellDir = "${homeDir}/Documents/code/dotfiles/home/services/quickshell/qml";
  quickshellTarget = "${homeDir}/.config/quickshell";
  faceIconSource = "${homeDir}/nixos/assets/profile.gif";
  faceIconTarget = "${homeDir}/.face.icon";
in {
  home.packages = with pkgs; [
    quickshell
  ];

  home.activation.symlinkUserChrome = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "${quickshellDir}" "${quickshellTarget}"
    ln -sfn "${faceIconSource}" "${faceIconTarget}"
  '';
}
