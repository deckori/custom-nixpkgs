{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "2.18.2.0";
  pname = "quba";

  src = fetchurl {
    url = "https://github.com/laggykiller/sticker-convert/releases/download/v${version}/sticker-convert-x86_64.AppImage";
    hash = lib.fakeHash;
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'
  '';

  meta = {
    description = "Convert (animated) stickers to/from WhatsApp, Telegram, Signal, Line, Kakao, Naver Band, OGQ, Viber, Discord, iMessage. Written in Python.";
    homepage = "https://github.com/laggykiller/sticker-convert/";
    downloadPage = "https://github.com/laggykiller/sticker-convert/releases";
    license = lib.licenses.gpl2;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}
