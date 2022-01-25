{ dbus_proxy, lua, buildLuaPackage, fetchFromGitHub }:
let

  pname = "connman_dbus";

in
buildLuaPackage rec {
  version = "0.5.0";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${pname}";
    rev = "v${version}";
    sha256 = "1h7lphxcslz4i7dhxacw7qfrk993yaabvf8xjs7vhbvb3lz2ayi0";
  };

  propagatedBuildInputs = [ dbus_proxy ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${pname} "$out/share/lua/${lua.luaversion}/"
  '';

}
