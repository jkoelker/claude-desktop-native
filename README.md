<img src="https://raw.githubusercontent.com/claude-desktop-native/claude-desktop-native/main/assets/banner.png" alt="Claude Desktop Native" width="100%">

# Claude Desktop Native for Arch Linux

![AUR Version](https://img.shields.io/aur/version/claude-desktop-native?style=for-the-badge&logo=archlinux&logoColor=cyan&color=black&labelColor=1793d1)
![AUR License](https://img.shields.io/aur/license/claude-desktop-native?style=for-the-badge&logo=apache&logoColor=orange&color=black&labelColor=d63031)
![AUR Votes](https://img.shields.io/aur/votes/claude-desktop-native?style=for-the-badge&logo=thumbsup&logoColor=gold&color=black&labelColor=009432)
![AUR Popularity](https://img.shields.io/aur/popularity/claude-desktop-native?style=for-the-badge&logo=hotjar&logoColor=yellow&color=black&labelColor=e84118)
![AUR Maintainer](https://img.shields.io/aur/maintainer/claude-desktop-native?style=for-the-badge&logo=github&logoColor=white&color=black&labelColor=2c3e50)
![AUR Last Modified](https://img.shields.io/aur/last-modified/claude-desktop-native?style=for-the-badge&logo=linux&logoColor=lime&color=black&labelColor=5f27cd)

> **Note**: This is a community-maintained package and is not affiliated with Anthropic. Use at your own risk.

## Overview

This unofficial AUR package brings Claude Desktop to Arch Linux natively, allowing you to use Anthropic's AI assistant on your Linux machine without virtualization or emulation.

## Attribution

This package relies on the `patchy-cnb` library created by [k3d3](https://github.com/k3d3) as part of the [claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake) project. All credit for the technical solution goes to k3d3.

## Installation

```bash
# Using yay
yay -S claude-desktop-native

# Using paru
paru -S claude-desktop-native

# Manual installation
git clone https://aur.archlinux.org/claude-desktop-native.git
cd claude-desktop-native
makepkg -si
```

## Features

- Native Claude Desktop experience on Arch Linux
- Modified native bindings for Linux compatibility via `patchy-cnb`
- Preserves all functionality of the official Claude Desktop application
- Seamless desktop environment integration (icons, shortcuts, etc.)
- Transparent implementation with no additional telemetry

## Implementation

The project works by:

1. Obtaining the official Windows executable
2. Extracting the Electron application files
3. Replacing Windows-specific native bindings with Linux-compatible alternatives
4. Repackaging everything to work with the system's Electron installation

The core functionality is provided by `patchy-cnb`, which implements alternative versions of the native functions that Claude Desktop expects.

## Dependencies

- electron
- nodejs/npm (build-time)
- rust/cargo (build-time)

## Community Projects

Similar community-maintained packages for other distributions:

### NixOS
- [k3d3/claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake) - Original implementation

### Debian
- [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian) - Seeking new maintainer

### Ubuntu
- [hanpham32/claude-desktop-linux-installer](https://github.com/hanpham32/claude-desktop-linux-installer)

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Blank screen on startup | Verify Electron version compatibility |
| Authentication fails | Check account credentials and internet connection |
| Missing icons | Reinstall the package |

For other issues, please [open an issue](https://github.com/claude-desktop-native/claude-desktop-native/issues) on GitHub.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

- Build scripts and packaging code: Dual-licensed under MIT License and Apache License 2.0
- Claude Desktop: Proprietary software owned by Anthropic
- patchy-cnb library: Created by k3d3, dual-licensed under MIT and Apache 2.0

## Acknowledgments

- [k3d3](https://github.com/k3d3) for creating patchy-cnb and the original implementation
- The Anthropic team for creating Claude
- The Arch Linux community for their package management system