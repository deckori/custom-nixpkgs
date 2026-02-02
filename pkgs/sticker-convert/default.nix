{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "2.18.2.0";
  pname = "sticker-convert";

  src = fetchurl {
    url = "https://github.com/laggykiller/sticker-convert/releases/download/v${version}/sticker-convert-x86_64.AppImage";
    hash = "sha256-12WLGNY+F29Lask6Zz7nMulZ7PYlWOYh5hLlz4Z48yA=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname src; };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/laggykiller/sticker-convert/refs/tags/v${version}/src/sticker_convert/resources/appicon.png";
    hash = "sha256-6XBEQz7PnerqS43aRkwpWolFG4WvKMuQ+st1ly+/JPg=";
  };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
      # icon
      mkdir -p $out/share/icons/hicolor/256x256/apps
      install -Dm644 ${icon} \
        $out/share/icons/hicolor/256x256/apps/sticker-convert.png

      # desktop entry
      mkdir -p $out/share/applications
      cat > $out/share/applications/sticker-convert.desktop <<EOF
    [Desktop Entry]
    Name=sticker-convert
    Exec=sticker-convert
    Icon=sticker-convert
    Type=Application
    Categories=Utility;
    Comment=Convert (animated) stickers between messaging platforms
    EOF
  '';

  meta = {
    mainProgram = "sticker-convert";
    description = "Convert (animated) stickers to/from WhatsApp, Telegram, Signal, Line, Kakao, Naver Band, OGQ, Viber, Discord, iMessage. Written in Python.";
    homepage = "https://github.com/laggykiller/sticker-convert/";
    downloadPage = "https://github.com/laggykiller/sticker-convert/releases";
    license = lib.licenses.gpl2;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}
