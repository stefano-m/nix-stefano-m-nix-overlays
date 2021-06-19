{ connman_dbus, lua, buildLuaPackage, fetchFromGitHub }:
let
  simpleName = "connman_widget";

in
buildLuaPackage rec {
  version = "0.3.0";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "1nq2pdxyaj6nmi04q45s1jbf4r6dcqi92xyzhppb7ks5cx0in0cj";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ connman_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${simpleName} "$out/share/lua/${lua.luaversion}/"
  '';

}
