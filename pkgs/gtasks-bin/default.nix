{
  lib,
  makeWrapper,
  stdenv,
  autoPatchelfHook,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "gtasks";
  version = "0.12.0"; # Or specify a particular version

  # Fetching the source from GitHub repository
  src = fetchurl {
    url = "https://github.com/BRO3886/gtasks/releases/download/v${version}/gtasks_linux_amd64_v${version}.tar.gz";
    sha256 = "sha256-BKpXIrzhz+8e4ZRtVCd4Phv1GhzQ/C9ZpSJT4NW07NA=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  # skip unpack, tarball is a single binary
  # unpackPhase = "true";
  #
  # buildPhase = "true";

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D gtasks $out/bin/gtasks
    runHook postInstall
  '';

  # installPhase = ''
  #   mkdir -p $out/bin
  #   cp $src/gtasks $out/bin/
  #   chmod +x $out/bin/gtasks
  #   wrapProgram $out/bin/gtasks \
  #     --prefix PATH : ${lib.makeBinPath [ stdenv.cc ]}
  # '';

  # postInstall = ''
  #   installShellCompletion --cmd gtasks \
  #     --bash <($out/bin/gtasks completion bash) \
  #     --fish <($out/bin/gtasks completion fish) \
  #     --zsh <($out/bin/gtasks completion zsh)
  # '';
  # Optional, add meta information
  meta = with lib; {
    description = "A command-line task manager written in Go";
    homepage = "https://github.com/BRO3886/gtasks";
    license = licenses.mit;
    maintainers = with maintainers; [
      niksingh710
    ];
  };
}
