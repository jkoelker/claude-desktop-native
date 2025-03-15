# Claude Desktop Native for Arch Linux

[!NOTE]

> This is a community-maintained package and is not affiliated with Anthropic. Use at your own risk.

This repo provides Claude Desktop running natively on Arch Linux.

There are other community-maintained packages for other distributions:

## Credits

This package is based on the approach from [k3d3/claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake), who developed the [patchy-cnb](https://github.com/k3d3/claude-desktop-linux-flake/tree/main/patchy-cnb) library.

[NixOS](https://github.com/k3d3/claude-desktop-linux-flake)

- [k3d3/claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake)
  [Debian](https://github.com/aaddrick/claude-desktop-debian)
- [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian)
  - Looking for a new maintainer. Please contribute to their cause if you are interested!
    [Ubuntu](https://github.com/hanpham32/claude-desktop-linux-installer)
- [hanpham32/claude-desktop-linux-installer](https://github.com/hanpham32/claude-desktop-linux-installer)

## Description

[Claude Desktop](https://claude.ai/download) is an Electron-based desktop application for using Anthropic's [Claude AI assistant] (<https://claude.ai>). Currently Claude Desktop is in beta and is only available for [Windows](https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest-win-x64/Claude-Setup-x64.exe) and [MacOS](https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest/Claude.dmg).

## Implementation Details

The original Claude Desktop application uses Windows-specific native bindings which are incompatible with Linux. See [k3d3/claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake) who [explains how it works](https://github.com/k3d3/claude-desktop-linux-flake?tab=readme-ov-file#how-it-works) in their original implementation.

## License

The build scripts and patchy-cnb implementation are dual-licensed under the MIT License and Apache License 2.0. Claude Desktop itself is proprietary software owned by Anthropic.
