self: super:

{
  extraLuaPackages = self.callPackage ./lua { };

  protonmail-bridge = self.callPackage ./protonmail-bridge { };
}
