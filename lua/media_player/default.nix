{ dbus_proxy, lua, buildLuaPackage, fetchFromGitHub }:
let

  pname = "media_player";

in
buildLuaPackage rec {
  version = "0.3.1";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${pname}";
    rev = "v${version}";
    sha256 = "1c9aimf5kw6k800wv8cvazqyndbg9zgfv9yi38my8zmlrvjvmg6r";
  };

  propagatedBuildInputs = [ dbus_proxy ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${pname}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
