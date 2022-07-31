{ lua, lgi, buildLuaPackage, fetchFromGitHub }:
let

  pname = "dbus_proxy";

in
# TODO: add busted and checkPhase?
buildLuaPackage rec {
  version = "0.10.3";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${pname}";
    rev = "v${version}";
    sha256 = "sha256-Yd8TN/vKiqX7NOZyy8OwOnreWS5gdyVMTAjFqoAuces=";
  };

  propagatedBuildInputs = [ lgi ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${pname} "$out/share/lua/${lua.luaversion}/"
  '';

}
