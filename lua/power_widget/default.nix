{upower_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "power_widget";

in

buildLuaPackage rec {
  version = "0.5.2";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "02plylcxxb04sdzm6ncqy0wl66aw14j4hyy7dw9jhgsbgr0wyjdr";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ upower_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
