{ buildGoModule, fetchFromGitHub, libglvnd, libsecret, pkg-config }:
let
  version = "1.6.5";
  shortRev = "845074f";  # used for --version option
  vendorSha256 = "04aa7syp5hhpqxdpqlsmmbwywnbrh4ia0diym2935jbrqccnvm1k";
  sha256 = "0wyxcmjzxwvv72pdn9wqc904dawj7w47rl99dn8iy8gxgd4hlvmi";
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
    rev = "br-${version}";
  };

  subPackages = [ "cmd/Desktop-Bridge" ];

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
