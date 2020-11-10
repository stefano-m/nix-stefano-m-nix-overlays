{ buildGo113Module, fetchFromGitHub, libglvnd, libsecret, pkg-config }:

buildGo113Module rec {
  pname = "protonmail-bridge";
  version = "1.5.0";
  shortRev = "9a77650";  # used for --version option

  buildInputs = [ pkg-config libglvnd libsecret ];

  src = fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "br-${version}";
    sha256 = "19ircj2mdb7dnp8aj17zdkbv1aq9qra1hk5jxj7dikvha4mb0yll";
  };

  modSha256 = "13g5yd0s173mmlwjjr1pnkgji6zhp5b7hssrqn4l4j8pwb5n3h7r";

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
