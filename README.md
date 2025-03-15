# Claude Desktop Native for Arch Linux

![AUR Version](https://img.shields.io/aur/version/claude-desktop-native?style=for-the-badge&logo=archlinux&logoColor=cyan&color=black&labelColor=1793d1)
![AUR License](https://img.shields.io/aur/license/claude-desktop-native?style=for-the-badge&logo=apache&logoColor=orange&color=black&labelColor=d63031)
![AUR Votes](https://img.shields.io/aur/votes/claude-desktop-native?style=for-the-badge&logo=thumbsup&logoColor=gold&color=black&labelColor=009432)
![AUR Popularity](https://img.shields.io/aur/popularity/claude-desktop-native?style=for-the-badge&logo=hotjar&logoColor=yellow&color=black&labelColor=e84118)
![AUR Maintainer](https://img.shields.io/aur/maintainer/claude-desktop-native?style=for-the-badge&logo=github&logoColor=white&color=black&labelColor=2c3e50)
![AUR Last Modified](https://img.shields.io/aur/last-modified/claude-desktop-native?style=for-the-badge&logo=linux&logoColor=lime&color=black&labelColor=5f27cd)

> **Note:** This is a community-maintained package and is not affiliated with Anthropic. Use at your own risk.

An unofficial AUR package that brings Claude Desktop to Arch Linux natively, allowing you to use Anthropic's AI assistant on your Linux machine.

## ⚠️ Important Attribution

**This package relies entirely on the patchy-cnb library, which was created by [k3d3](https://github.com/k3d3) as part of the [claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake) project.** 

This AUR package is simply packaging that work for Arch Linux users. All credit for the technical solution that makes this possible belongs to k3d3.

## Quick Install

```bash
# Install using your AUR helper of choice
yay -S claude-desktop-native

# Or using paru
paru -S claude-desktop-native

# Or manually
git clone https://aur.archlinux.org/claude-desktop-native.git
cd claude-desktop-native
makepkg -si
```

## Features

- Run Claude Desktop natively on Arch Linux
- Uses modified native bindings for Linux compatibility (via patchy-cnb by k3d3)
- Preserves all functionality of the official Claude Desktop application
- Integrates with the Linux desktop environment (icons, shortcuts, etc.)

## How It Works

The official Claude Desktop application is available only for Windows and macOS. This package:

1. Downloads the official Windows executable
2. Extracts the Electron application files
3. **Replaces Windows-specific native bindings with Linux-compatible ones using the [patchy-cnb](https://github.com/claude-desktop-native/patchy-cnb) library created by k3d3**
4. Repackages everything to work with the system's Electron installation

The core functionality is provided by patchy-cnb, which was developed by k3d3 to provide alternative implementations of the native functions the Claude app expects.

## Dependencies

- electron
- nodejs/npm (build-time)
- rust/cargo (build-time)

## Community Projects

Similar community-maintained packages for other distributions:

### NixOS
- [k3d3/claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake) - **Original implementation that made this possible**

### Debian
- [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian) - Looking for a new maintainer!

### Ubuntu
- [hanpham32/claude-desktop-linux-installer](https://github.com/hanpham32/claude-desktop-linux-installer)

## Troubleshooting

### Common Issues

- **Blank screen on startup**: Make sure your system's Electron version is compatible
- **Authentication fails**: Ensure you have a valid Claude account and internet connection
- **Missing icons**: Try reinstalling the package

For other issues, please [open an issue](https://github.com/claude-desktop-native/claude-desktop-native/issues) on GitHub.

## Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The build scripts and packaging code are dual-licensed under the MIT License and Apache License 2.0.

Claude Desktop itself is proprietary software owned by Anthropic.

The patchy-cnb library is created by k3d3 and is dual-licensed under MIT and Apache 2.0 licenses.

## Acknowledgments

- **[k3d3](https://github.com/k3d3) for creating patchy-cnb and the original work on making Claude Desktop run on Linux**
- The Anthropic team for creating Claude
- The Arch Linux community for their excellent package management system
