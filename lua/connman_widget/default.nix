{ connman_dbus, lua, buildLuaPackage, fetchFromGitHub }:
let

  pname = "connman_widget";

in
buildLuaPackage rec {
  version = "0.3.0";
  name = "${pname}-${version}";
  inherit pname;

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${pname}";
    rev = "v${version}";
    sha256 = "1nq2pdxyaj6nmi04q45s1jbf4r6dcqi92xyzhppb7ks5cx0in0cj";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ connman_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r src/${pname} "$out/share/lua/${lua.luaversion}/"
  '';

}
