{pulseaudio_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "pulseaudio_widget";

in

buildLuaPackage rec {
  version = "0.5.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "0y7vbkjxd5x75nxzk6sjxszn6zf67zzm17csrpbv4h890rndzs3s";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ pulseaudio_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
