{ buildGoModule, fetchFromGitHub, libglvnd, libsecret, pkg-config, logToStderr ? true }:
let
  version = "2.1.3";
  shortRev = "51eb2c4";  # used for --version option
  vendorSha256 = "sha256-YTGjiteYfuRkDC4M9c/JKqURq4WiC5n9pFRqRVYhyxU=";
  sha256 = "0scjmymgwylfr7x2k6csvk7dfsfv4k279cn8lzwm87rd7j38sxzr";
in
buildGoModule rec {
  inherit version shortRev vendorSha256;

  pname = "protonmail-bridge";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libglvnd libsecret ];

  doCheck = false; # tests need upstream infrastructure.

  src = fetchFromGitHub {
    inherit sha256;
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "v${version}";
  };

  subPackages = [ "cmd/Desktop-Bridge" ];

  patches =
    if logToStderr then [
      ./patches/0001-Send-all-logs-to-stderr.patch
    ] else [ ];

  tags = [ "pmapi_prod" "nogui" ];

  preBuild = ''
    # See commit bad8cad
    cd ./utils
    bash ./credits.sh bridge
    cd ..
  '';

  ldflags = [
    "-X github.com/ProtonMail/proton-bridge/internal/constants.Version=${version}"
    "-X github.com/ProtonMail/proton-bridge/internal/constants.Revision=${shortRev}"
    "-X github.com/ProtonMail/proton-bridge/internal/constants.BuildTime=0"
    "-X main.ConfigName=bridge"
    "-X main.ExeName=proton-bridge"
  ];

  postInstall = "mv $out/bin/Desktop-Bridge $out/bin/protonmail-bridge";

}
