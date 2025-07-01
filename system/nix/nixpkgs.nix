{
  self,
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;

    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

    overlays = [
      # Your custom lib.colors overlay
      (final: prev: {
        lib =
          prev.lib
          // {
            colors = import "${self}/lib/colors" prev.lib;
          };
      })

      # Custom gnome-shell patch overlay with background image
      (self: super: {
        gnome-shell = super.gnome-shell.overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              (let
                bg = self.pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/rose-pine/wallpapers/main/bay.JPG";
                  sha256 = "1hpq37s0cwnygdpcy7w46iyl9dqfqnf46hlci5q97f4asj7yrcb0";
                };
              in
                self.pkgs.writeText "bg.patch" ''
                  --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                  +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                  @@ -15,4 +15,6 @@ $_gdm_dialog_width: 23em;
                   /* Login Dialog */
                   .login-dialog {
                     background-color: $_gdm_bg;
                  +  background-image: url('file://${bg}');
                  +  background-size: cover;
                   }
                '')
            ];
        });
      })

      # External overlays
      inputs.niri.overlays.niri
      inputs.nix-yazi-flavors.overlay
    ];
  };
}
