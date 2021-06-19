{ pulseaudio_dbus, lua, buildLuaPackage, fetchFromGitHub }:
let

  simpleName = "pulseaudio_widget";

in
buildLuaPackage rec {
  version = "0.6.1";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "1ccar5wxz38d2yh3xyrgzk8xhv171awmrn94b89y9f7ri88iiddv";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ pulseaudio_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
