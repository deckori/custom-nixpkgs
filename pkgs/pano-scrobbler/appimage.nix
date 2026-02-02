# The desktop version is bugged. Web scrobbler is a better alternative
{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "420";
  pname = "pano-scrobbler";

  src = fetchurl {
    url = "https://github.com/kawaiiDango/pano-scrobbler/releases/download/${version}/${pname}-linux-x64.AppImage";
    hash = "sha256-LBU7kz6cBn+O1fEfyQ/sT7eHs6x0XLGw3B5bm0y/HGM=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [ webkitgtk_4_1.dev ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/pano-scrobbler.desktop -t $out/share/applications/
    install -Dm444 ${appimageContents}/pano-scrobbler.svg -t $out/share/icons/hicolor/scalable/apps/
    substituteInPlace $out/share/applications/pano-scrobbler.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=pano-scrobbler'
  '';

  meta = {
    description = "Feature packed cross-platform music tracker for Last.fm, ListenBrainz, Libre.fm, Pleroma and more";
    homepage = "https://github.com/kawaiiDango/pano-scrobbler";
    downloadPage = "https://github.com/kawaiiDango/pano-scrobbler/releases";
    license = lib.licenses.gpl3Plus;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
