{upower_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "power_widget";

in

buildLuaPackage rec {
  version = "0.5.4";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "0bnghmrh2kd623rip1fmi5sblpf7cb4g1iky7mhmv6f0825ffgkw";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ upower_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
