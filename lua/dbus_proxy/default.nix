{lua, lgi, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "dbus_proxy";

in

# TODO: add busted and checkPhase?
buildLuaPackage rec {
  version = "0.9.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${simpleName}";
    rev = "v${version}";
    sha256 = "0s3xl2sbrc494vsh8wqlh5xdmpfl42annm4nmns24ipkqfm3bf2i";
  };

  propagatedBuildInputs = [ lgi ];

  buildPhase = ":";

  installPhase = ''
  mkdir -p "$out/share/lua/${lua.luaversion}"
  cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
