{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  alsa-lib,
  webkitgtk_4_1,
  gtk3,
  glib,
  libsoup_3,
  cairo,
  pango,
  gdk-pixbuf,
  atk,
  nodejs,
  pnpm,
  lld,
  fetchPnpmDeps,
  pnpmConfigHook,
  makeWrapper,
  gst_all_1,
}:
rustPlatform.buildRustPackage rec {
  pname = "onetagger";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "Marekkon5";
    repo = "onetagger";
    rev = "2429a833cbafb9b057bc9e2268806e571a3ca1b5";
    hash = "sha256-EXkuBlOA/qBrgrckyufJ3HgxsaUycbYdfF9PanZ0O4g=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "songrec-0.2.1" = "sha256-pQKU99x52cYQjBVctsI4gdju9neB6R1bluL76O1MZMw=";
    };
  };

  pnpmDeps = fetchPnpmDeps {
    fetcherVersion = 4;
    pname = "${pname}-pnpm-deps";
    inherit version src;
    sourceRoot = "source/client";
    postPatch = ''
      cp ${./pnpm-lock.yaml} pnpm-lock.yaml
    '';
    hash = "sha256-IHKJPiWHKHZvDYj+vBcnZ/y0qH2pOQ5T5K9M5rMVsPw=";
  };

  nativeBuildInputs = [
    pkg-config
    nodejs
    pnpm
    lld
    pnpmConfigHook
    makeWrapper
  ];

  buildInputs = [
    openssl
    alsa-lib
    webkitgtk_4_1
    gtk3
    glib
    libsoup_3
    cairo
    pango
    gdk-pixbuf
    atk
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
  ];

  pnpmRoot = "client";

  preBuild = ''
    export HOME="$(mktemp -d)"

    cd client
    pnpm install --offline --frozen-lockfile
    pnpm run build
    cd ..
  '';

  postPatch = ''
    cp ${./pnpm-lock.yaml} client/pnpm-lock.yaml
  '';

  doCheck = false;

  postFixup = ''
    for bin in $out/bin/onetagger $out/bin/onetagger-cli; do
      wrapProgram "$bin" \
        --prefix LD_LIBRARY_PATH : ${
          lib.makeLibraryPath [
            alsa-lib
            webkitgtk_4_1
            gtk3
            glib
            libsoup_3
            cairo
            pango
            gdk-pixbuf
            atk
            openssl
            gst_all_1.gstreamer
            gst_all_1.gst-plugins-base
          ]
        } \
        --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0"
    done
  '';

  meta = with lib; {
    description = "Cross-platform music tagger for DJs";
    homepage = "https://github.com/Marekkon5/onetagger";
    license = licenses.gpl3Only;
    broken = false;
  };
}
