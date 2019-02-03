{dbus_proxy, enum, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "upower_dbus";

in

buildLuaPackage rec {
  version = "0.3.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${simpleName}";
    rev = "v${version}";
    sha256 = "1mnnhc1g79gfgw3h6x6c3582psa3xnpfgvpkh9fay4n2kbw8y4hx";
  };

  propagatedBuildInputs = [
    dbus_proxy
    enum
  ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
