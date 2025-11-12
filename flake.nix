{
  description = "A flake to build FFmpeg from source";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ffmpeg-src = {
      url = "github:FFmpeg/FFmpeg/n8.0";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ffmpeg-src }: {

    packages.x86_64-linux.ffmpeg8 = 
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      pkgs.ffmpeg-full.overrideAttrs (old: {
        src = ffmpeg-src;
        version = "git-${ffmpeg-src.rev or "unknown"}";
        # Remove patches that don't apply to the latest source
        patches = [ ];
        # Filter out configure flags that don't exist in latest FFmpeg
        configurePlatforms = [ ];
        configureFlags = builtins.filter 
          (flag: flag != "--enable-postproc" && flag != "--enable-lcevc" && flag != "--enable-liblcevc-dec")
          old.configureFlags;
        # Remove lcevcdec from buildInputs to avoid API incompatibility
        buildInputs = builtins.filter
          (dep: !(builtins.hasAttr "pname" dep) || dep.pname or "" != "lcevcdec")
          old.buildInputs;
        # Ensure nasm and other build tools are available
        nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.nasm ];
        # Prevent configure from finding lcevcdec
        preConfigure = (old.preConfigure or "") + ''
          export PKG_CONFIG_PATH=$(echo "$PKG_CONFIG_PATH" | tr ':' '\n' | grep -v lcevcdec | tr '\n' ':')
        '';
      });

    packages.x86_64-linux.default = self.packages.x86_64-linux.ffmpeg8;

  };
}
