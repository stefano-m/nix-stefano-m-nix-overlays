{ buildGoModule, fetchFromGitHub, libglvnd, libsecret, pkg-config }:

buildGoModule rec {
  pname = "protonmail-bridge";
  version = "1.5.2";
  shortRev = "072ce54";  # used for --version option

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libglvnd libsecret ];

  doCheck = false;  # tests need upstream infrastructure.

  src = fetchFromGitHub {
    owner = "ProtonMail";
    repo = "proton-bridge";
    rev = "br-${version}";
    sha256 = "1mv7fwapcarii43nnsgk7ifqlah07k54zk6vxxxmrp04gy0mzki6";
  };

  vendorSha256 = "01d6by8xj9py72lpfns08zqnsym98v8imb7d6hgmnzp4hfqzbz3c";

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
