{ lua, luaPackages, callPackage, ... }:

assert lua.luaversion == luaPackages.lua.luaversion;

rec {

  dbus_proxy = callPackage ./dbus_proxy {
    inherit (luaPackages) lgi buildLuaPackage;
  };

  connman_dbus = callPackage ./connman_dbus {
    inherit dbus_proxy;
    inherit (luaPackages) buildLuaPackage;
  };

  connman_widget = callPackage ./connman_widget {
    inherit connman_dbus;
    inherit (luaPackages) buildLuaPackage;
  };

  enum = callPackage ./enum {
    inherit (luaPackages) buildLuaPackage;
  };

  media_player = callPackage ./media_player {
    inherit dbus_proxy;
    inherit (luaPackages) buildLuaPackage;
  };

  pulseaudio_dbus = callPackage ./pulseaudio_dbus {
    inherit dbus_proxy;
    inherit (luaPackages) buildLuaPackage;
  };

  pulseaudio_widget = callPackage ./pulseaudio_widget {
    inherit pulseaudio_dbus;
    inherit (luaPackages) buildLuaPackage;
  };

  upower_dbus = callPackage ./upower_dbus {
    inherit dbus_proxy enum;
    inherit (luaPackages) buildLuaPackage;
  };

  power_widget = callPackage ./power_widget {
    inherit upower_dbus;
    inherit (luaPackages) buildLuaPackage;
  };

}
