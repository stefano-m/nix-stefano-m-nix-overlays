{ lua, lgi, buildLuaPackage, fetchFromGitHub }:
let

  pname = "dbus_proxy";

in
# TODO: add busted and checkPhase?
buildLuaPackage rec {
  version = "0.10.2";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${pname}";
    rev = "v${version}";
    sha256 = "0kl8ff1g1kpmslzzf53cbzfl1bmb5cb91w431hbz0z0vdrramh6l";
  };

  propagatedBuildInputs = [ lgi ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${pname} "$out/share/lua/${lua.luaversion}/"
  '';

}
