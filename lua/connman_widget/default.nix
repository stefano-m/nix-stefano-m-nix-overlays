{connman_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let
  simpleName = "connman_widget";

in

buildLuaPackage rec {
  version = "0.2.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 ="01fyb9rqadj4gmm3cg711f306cnnpnf9pg20frbh6mnzwbzj38ww";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ connman_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
