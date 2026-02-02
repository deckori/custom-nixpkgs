{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  unstableGitUpdater,
}:

stdenvNoCC.mkDerivation {
  pname = "alias-finder-nu";
  version = "0-unstable-2025-12-25";

  src = fetchFromGitHub {
    owner = "KamilKleina";
    repo = "alias-finder.nu";
    rev = "952658bb51116c255d0c6463b602b24426d5ef90";
    hash = "sha256-3IBIyrnIFzjYzxtUYFsQeMeP0S/t7IU6ZF428lAwScw=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/alias-finder
    mv ./* $out/share/alias-finder

    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Place to share Nushell scripts with each other";
    homepage = "https://github.com/nushell/nu_scripts";
    license = lib.licenses.mit;

    platforms = lib.platforms.unix;
  };
}
