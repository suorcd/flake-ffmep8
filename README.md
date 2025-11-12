# flake-ffmep-full

A Nix flake that builds FFmpeg from source using the latest code from the official FFmpeg repository, with all features enabled (ffmpeg-full configuration).

## Usage

> **Note:** If you're on a system where flakes are not enabled by default, add `--experimental-features 'nix-command flakes'` to any `nix` command below.

### Run locally (for testing)

From within this repository:

```bash
nix run .
```

Or with flakes enabled inline:

```bash
nix --experimental-features 'nix-command flakes' run .
```

### Run directly from GitHub

Once pushed to GitHub:

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

### Use in a shell environment

To use ffmpeg-full in a temporary shell (like `nix-shell`):

```bash
nix shell github:suorcd/flake-ffmep-full
```

Or locally:

```bash
nix shell .
```

Or with flakes enabled inline:

```bash
nix --experimental-features 'nix-command flakes' shell github:suorcd/flake-ffmep-full
# or locally:
nix --experimental-features 'nix-command flakes' shell .
```

This will add `ffmpeg` to your PATH for the duration of the shell session.

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

This flake builds FFmpeg from the latest source code in the official FFmpeg repository (https://github.com/FFmpeg/FFmpeg), using the full feature set from nixpkgs' `ffmpeg-full` package configuration. This means you get:

- The latest FFmpeg code from the master branch
- All optional features and codecs enabled
- Proper Nix build environment and dependencies

## Note on Build Time

Since this flake builds FFmpeg from source, the first build will take significantly longer than using a pre-built package. Subsequent builds will use Nix's cache unless the FFmpeg source has been updated.