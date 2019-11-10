{dbus_proxy, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "connman_dbus";

in

buildLuaPackage rec {
  version = "0.5.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${simpleName}";
    rev = "v${version}";
    sha256 = "1h7lphxcslz4i7dhxacw7qfrk993yaabvf8xjs7vhbvb3lz2ayi0";
  };

  propagatedBuildInputs = [ dbus_proxy ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
