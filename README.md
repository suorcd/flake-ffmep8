# flake-ffmep-full

A Nix flake that provides ffmpeg-full from nixpkgs unstable.

## Usage

> **Note:** If you're on a system where flakes are not enabled by default, add `--experimental-features 'nix-command flakes'` to any `nix` command below.

### Run directly

```bash
nix run github:suorcd/flake-ffmep-full
```

Or with flakes enabled inline:

```bash
nix --experimental-features 'nix-command flakes' run github:suorcd/flake-ffmep-full
```

### Build locally

```bash
nix build
```

The built package will be available in `./result/bin/ffmpeg`.

### Use in another flake

Add to your `flake.nix`:

```nix
{
  inputs = {
    ffmpeg-full.url = "github:suorcd/flake-ffmep-full";
  };

  outputs = { self, ffmpeg-full, ... }: {
    # Use ffmpeg-full.packages.x86_64-linux.default
  };
}
```

### Install to your profile

```bash
nix profile install github:suorcd/flake-ffmep-full
```

## What's included

This flake provides the full ffmpeg package with all optional features enabled, directly from nixpkgs unstable.