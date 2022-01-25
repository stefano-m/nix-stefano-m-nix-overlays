{ dbus_proxy, enum, lua, buildLuaPackage, fetchFromGitHub }:
let

  pname = "upower_dbus";

in
buildLuaPackage rec {
  version = "0.3.0";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${pname}";
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
    cp -r src/${pname} "$out/share/lua/${lua.luaversion}/"
  '';

}
