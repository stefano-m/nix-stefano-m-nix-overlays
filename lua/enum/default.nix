{ lua, buildLuaPackage, fetchFromGitHub }:
let

  pname = "enum";

in
buildLuaPackage rec {
  version = "0.1.1";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "lua-${pname}";
    rev = "v${version}";
    sha256 = "1lz0v1sihxxlnn0z2x3wv8gr6xg4q5pw7da2x9hh9cgqgz4v4xib";
  };

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${pname} "$out/share/lua/${lua.luaversion}/"
  '';

}
