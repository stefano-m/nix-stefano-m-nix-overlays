{ buildGoModule, fetchFromGitHub, libglvnd, libsecret, pkg-config }:

buildGoModule rec {
  pname = "protonmail-bridge";
  version = "1.5.0";
  shortRev = "9a77650";  # used for --version option

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libglvnd libsecret ];

  doCheck = false;  # tests need upstream infrastructure.

  src = fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "br-${version}";
    sha256 = "19ircj2mdb7dnp8aj17zdkbv1aq9qra1hk5jxj7dikvha4mb0yll";
  };

  vendorSha256 = "061mffkk7m3pwv2hv0hwvbk9m9pyr28581ra5ibpzdawl1zbpzvq";

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
