{ buildGoModule, fetchFromGitHub, libglvnd, libsecret, pkg-config, logToStderr ? true }:
let
  version = "2.1.1";
  shortRev = "c35ff4f";  # used for --version option
  vendorSha256 = "sha256-n+WwkNHT+/CrC4vWIVHqYs2a8Qe/LNc0L3uoPZWDTts=";
  sha256 = "0682gvcarfhr7cnyidfpphlgcwsknlv593w0cr83nrir0paw107j";
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
