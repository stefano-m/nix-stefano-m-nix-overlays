{upower_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "power_widget";

in

buildLuaPackage rec {
  version = "0.5.1";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "02k850xc133hwqrdsrxhmgwbdvl127lx6l1bd71ajh4f4476a8fy";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ upower_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
