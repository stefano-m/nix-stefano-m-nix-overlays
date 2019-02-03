{dbus_proxy, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "connman_dbus";

in

buildLuaPackage rec {
  version = "0.4.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${simpleName}";
    rev = "v${version}";
    sha256 = "1jpg757q0s2rj3brccbka5ad514bqcq97qisxf2zc6pk5ql0jbn0";
  };

  propagatedBuildInputs = [ dbus_proxy ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
