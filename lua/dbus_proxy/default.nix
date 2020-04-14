{lua, lgi, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "dbus_proxy";

in

# TODO: add busted and checkPhase?
buildLuaPackage rec {
  version = "0.10.1";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${simpleName}";
    rev = "v${version}";
    sha256 = "064xqzc2jvag25s6kq0k5hirpghkfpgyyv1h4f7w5qmvzglxh7kz";
  };

  propagatedBuildInputs = [ lgi ];

  buildPhase = ":";

  installPhase = ''
  mkdir -p "$out/share/lua/${lua.luaversion}"
  cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
