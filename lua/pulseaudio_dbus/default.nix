{ dbus_proxy, lua, buildLuaPackage, fetchFromGitHub }:
let

  simpleName = "pulseaudio_dbus";

in
buildLuaPackage rec {
  version = "0.12.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${simpleName}";
    rev = "v${version}";
    sha256 = "1l4nalziwmy3d7sb4jij2d1cml5ghzkg8cwj25v82brj36v3kqd7";
  };

  propagatedBuildInputs = [ dbus_proxy ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
