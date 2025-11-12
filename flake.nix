{
  description = "A flake to build FFmpeg from source";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ffmpeg-src = {
      url = "github:FFmpeg/FFmpeg";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ffmpeg-src }: {

    packages.x86_64-linux.ffmpeg-full = 
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      pkgs.ffmpeg-full.overrideAttrs (old: {
        src = ffmpeg-src;
        version = "git-${ffmpeg-src.rev or "unknown"}";
        # Remove patches that don't apply to the latest source
        patches = [ ];
      });

    packages.x86_64-linux.default = self.packages.x86_64-linux.ffmpeg-full;

  };
}
