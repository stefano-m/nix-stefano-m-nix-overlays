{upower_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "power_widget";

in

buildLuaPackage rec {
  version = "0.5.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "0mgbc00n654j88dpxfacaa19rc818hjvqqinq8rrdzyvbdjw3rha";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ upower_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
