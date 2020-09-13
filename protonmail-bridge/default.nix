{ buildGo113Module, fetchFromGitHub, libglvnd, libsecret, pkg-config }:

buildGo113Module rec {
  pname = "protonmail-bridge";
  version = "1.3.3";
  shortRev = "01a8c9e";  # used for --version option

  buildInputs = [ pkg-config libglvnd libsecret ];

  src = fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "v${version}";
    sha256 = "19rpsxci9mrpviw5janjy588v4278iydlj3bsfkn99csrvn9qcl9";
  };

  modSha256 = "1rb4mxv9x3byd2aag7nx14gh3sqi7f2nq0izy10ygqz1w9k3g7cb";

  subPackages = [ "cmd/Desktop-Bridge" ];

  buildFlags = [
    "-tags pmapi_prod"
    "-tags nogui"
  ];

  buildFlagsArray = ''
    -ldflags=
      -X github.com/ProtonMail/proton-bridge/pkg/constants.Version=${version}
      -X github.com/ProtonMail/proton-bridge/pkg/constants.Revision=${shortRev}
      -X github.com/ProtonMail/proton-bridge/pkg/constants.BuildTime=0
  '';

  postInstall = "mv $out/bin/Desktop-Bridge $out/bin/protonmail-bridge";

}
