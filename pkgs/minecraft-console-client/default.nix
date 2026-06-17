{
  fetchFromGitHub,
  lib,
  buildDotnetModule,
  dotnetCorePackages,
}:

buildDotnetModule rec {
  pname = "minecraft-console-client";
  version = "20260613-165";

  src = fetchFromGitHub {
    owner = "milutinke";
    repo = "Minecraft-Console-Client";
    rev = version;
    fetchSubmodules = true;
    # hash = "sha256-8D0SVI70PAEyY1QM20yLj+bMDsbUGJ+6rma8MPaisf0=";
    hash = lib.fakeHash;
  };

  projectFile = "MinecraftClient/MinecraftClient.csproj";
  nugetDeps = ./deps.json;

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;
  dotnetFlags = [ "-p:RuntimeFrameworkVersion=${dotnet-runtime.version}" ];

  meta = {
    mainProgram = "MinecraftClient";
    description = "Lightweight console for Minecraft chat and automated scripts";
    homepage = "https://github.com/milutinke/Minecraft-Console-Client";
    license = lib.licenses.cddl;
  };
}
