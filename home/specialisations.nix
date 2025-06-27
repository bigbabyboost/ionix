{
  theme = {
    wallpaper = let
      url = "https://w.wallhaven.cc/full/ex/wallhaven-exgyok.jpg";
      sha256 = "06653zg1h8fh1wpiqpibcy7npzmscb7ns2p2vpzx9sn4qg7pn64l";
      ext = "jpg";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
