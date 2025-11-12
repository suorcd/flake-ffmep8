{
  description = "A flake ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.ffmpeg-full = nixpkgs.legacyPackages.x86_64-linux.ffmpeg-full;

    packages.x86_64-linux.default = self.packages.x86_64-linux.ffmpeg-full;

  };
}
