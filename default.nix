self: super:

{
  luaPackages = super.luaPackages // self.callPackage ./lua {};

  lua52Packages = super.lua52Packages // self.callPackage ./lua {};

  lua53Packages = super.lua53Packages // self.callPackage ./lua {};
}
