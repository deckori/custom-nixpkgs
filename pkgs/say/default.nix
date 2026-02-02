{
  fetchFromGitHub,
  buildGo125Module,
  ...
}:

buildGo125Module {
  pname = "say";
  version = "0.1.0";
  # subPackages = [ "ziti" ];
  src = fetchFromGitHub {
    owner = "svanichkin";
    repo = "say";
    rev = "7b67bb1dfc18267e1e1fcf306e7fa70cdbb7efa1";
    hash = "sha256-X6Iv8I6KDraaGBydtKe3RU3u4c+3NBDzfWSqM+lKyxg=";
  };
  vendorHash = "sha256-OaaCpHa/+7vaG6x8gGpHRlg0njOKkLUtad6fOWTetoM=";
}
