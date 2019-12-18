{upower_dbus, lua, buildLuaPackage, fetchFromGitHub}:

let

  simpleName = "power_widget";

in

buildLuaPackage rec {
  version = "0.5.3";
  name = "${simpleName}-${version}";

  src = fetchFromGitHub {
    owner = "stefano-m";
    repo = "awesome-${simpleName}";
    rev = "v${version}";
    sha256 = "17gg4nd8lhmfdqw12f01v0a6c8sl12q556wsg4ysrlnlfp0rr31c";
  };

  # FIXME: cannot find awesome libraries
  propagatedBuildInputs = [ upower_dbus ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p "$out/share/lua/${lua.luaversion}"
    cp -r ${simpleName}.lua "$out/share/lua/${lua.luaversion}/"
  '';

}
