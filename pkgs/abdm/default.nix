{
  lib,
  fetchurl,
  buildFHSEnv,
  glibc,
  jdk,
  glib,
  zlib,
  alsa-lib,
  libglvnd,
  libXi,
  freetype,
  libXtst,
  libXrender,
  fontconfig,
  libX11,
  libXext,
  gtk3,
  libxkbcommon,
  libXrandr,
  cairo,
  pango,
}: let
  pname = "abdownloadmanager";
  version = "1.6.4";
  src = fetchurl {
    url = "https://github.com/amir1376/ab-download-manager/releases/download/v${version}/ABDownloadManager_${version}_linux_x64.tar.gz";
    sha256 = "sha256-nyYs70Y+uorjpmK20pxIvMj9iTDHItbHN2F/tIEd4os=";
  };
in
  buildFHSEnv {
    name = pname;

    targetPkgs = pkgs:
      with pkgs; [
        glibc
        jdk
        glib
        zlib
        alsa-lib
        libglvnd
        libXi
        freetype
        libXtst
        libXrender
        fontconfig
        libX11
        libXext
        gtk3
        libxkbcommon
        libXrandr
        cairo
        pango
      ];

    runScript = "abdm";

    extraInstallCommands = ''
          mkdir -p $out/opt/ABDownloadManager
          tar -xzf ${src} -C $out/opt/ABDownloadManager --strip-components=1

          mkdir -p $out/bin << EOF
      #!/bin/sh
      export GDK_BACKEND=x11
      export JAVA_HOME=${jdk}
      export PATH=\$JAVA_HOME/bin:\$PATH
      export LD_LIBRARY_PATH=${lib.makeLibraryPath [
        glib
        libXext
        libX11
        libXtst
        libXrender
        fontconfig
        freetype
        libXi
        zlib
        alsa-lib
        libglvnd
        gtk3
        libxkbcommon
        libXrandr
        cairo
        pango
      ]}:\$LD_LIBRARY_PATH
      export JAVA_LIBRARY_PATH=\$JAVA_HOME/lib/server
      cd "$out/opt/ABDownloadManager"
      exec ./bin/ABDownloadManager "\$@"
      EOF

          install -Dm644 $out/opt/ABDownloadManager/lib/ABDownloadManager.png \
            $out/share/pixmaps/ABDownloadManager.png

          mkdir -p $out/share/applications
          cat > $out/share/applications/ABDownloadManager.desktop << EOF
      [Desktop Entry]
      Name=ABDownloadManager
      Exec=abdownloadmanager
      Type=Application
      Icon=ABDownloadManager
      Comment=A Kotlin based download manager
      Categories=Network;FileTransfer;
      EOF
    '';

    meta = with lib; {
      description = "A Kotlin based download manager";
      homepage = "https://github.com/amir1376/ab-download-manager";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [maintainers.lonerOrz];
    };
  }
