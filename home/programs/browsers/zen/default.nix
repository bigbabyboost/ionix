{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight-official];

  programs = {
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
      profiles.xaolan = {
        id = 0;
        isDefault = true;
        search = {
          force = true;
          order = [
            "Startpage"
            "Searx"
            "NixOS Packages"
            "NixOS Options"
            "NixOS Wiki"
            "Home Manager Options"
            "google"
          ];
          default = "Startpage";
          engines = {
            "Startpage" = {
              urls = [
                {
                  template = "https://www.startpage.com/sp/search?query={searchTerms}&prfe=c602752472dd4a3d8286a7ce441403da08e5c4656092384ed3091a946a5a4a4c99962d0935b509f2866ff1fdeaa3c33a007d4d26e89149869f2f7d0bdfdb1b51aa7ae7f5f17ff4a233ff313d";
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@sp"];
            };

            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nw"];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://mipmip.github.io/home-manager-option-search";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master";
                    }
                  ];
                }
              ];
              icon = "https://avatars.githubusercontent.com/u/33221035";
              updateInterval = 24 * 60 * 60 * 1000; # Update every day.
              definedAliases = ["@hm"];
            };
            "google".metaData.alias = "@g";
          };
        };
        extraConfig = ''
          ${builtins.readFile "${inputs.betterfox}/zen/user.js"}
        '';
      };
    };
  };
}
