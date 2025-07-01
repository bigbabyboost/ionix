{pkgs, lib, ...}: {
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      youtubeSupport = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        sponsorblock
    	thumbnail
    	modernz
    	smartskip
    	youtube-chat
    	quality-menu
    	youtube-upnext
    	# autosubsync-mpv
    	autoload
    	smart-copy-paste-2
      ];
    };
    defaultProfiles = ["fast"];
  };
  xdg.configFile = {
  	"mpv/fonts/fluent-system-icons.ttf".source = "${pkgs.mpvScripts.modernz}/share/fonts/fluent-system-icons.ttf";
    "mpv/fonts/material-design-icons.ttf".source = "${pkgs.mpvScripts.modernz}/share/fonts/material-design-icons.ttf";
    "mpv/mpv.conf".source = ./mpv.conf;
    "mpv/input.conf".source = ./input.conf;
  };
}
