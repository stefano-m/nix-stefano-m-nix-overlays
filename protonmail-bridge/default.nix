{ buildGoModule, fetchFromGitHub, libglvnd, libsecret, pkg-config, logToStderr ? true }:
let
  version = "1.8.7";
  shortRev = "7ab54da";  # used for --version option
  vendorSha256 = "sha256-g2vl1Ctxr2U+D/k9u9oXuZ1OWaABIJs0gmfhWh13ZFM=";
  sha256 = "1887qa59i4vj3q71sd48hdcrinq0gm235qync6qqapsy0ywcyabg";
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

  buildFlags = [
    "-tags pmapi_prod"
    "-tags nogui"
  ];

  preBuild = ''
    # See commit bad8cad
    cd ./utils
    bash ./credits.sh bridge
    bash ./credits.sh importexport
    cd ..
  '';

  buildFlagsArray = ''
    -ldflags=
      -X github.com/ProtonMail/proton-bridge/internal/constants.Version=${version}
      -X github.com/ProtonMail/proton-bridge/internal/constants.Revision=${shortRev}
      -X github.com/ProtonMail/proton-bridge/internal/constants.BuildTime=0
      -X main.ConfigName=bridge
      -X main.ExeName=proton-bridge
  '';

  postInstall = "mv $out/bin/Desktop-Bridge $out/bin/protonmail-bridge";

}
