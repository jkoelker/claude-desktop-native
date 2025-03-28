# Claude Desktop Native for Arch Linux

![AUR Version](https://img.shields.io/aur/version/claude-desktop-native?style=for-the-badge&logo=archlinux&logoColor=cyan&color=black&labelColor=1793d1)
![AUR License](https://img.shields.io/aur/license/claude-desktop-native?style=for-the-badge&logo=apache&logoColor=orange&color=black&labelColor=d63031)
![AUR Votes](https://img.shields.io/aur/votes/claude-desktop-native?style=for-the-badge&logo=thumbsup&logoColor=gold&color=black&labelColor=009432)
![AUR Popularity](https://img.shields.io/aur/popularity/claude-desktop-native?style=for-the-badge&logo=hotjar&logoColor=yellow&color=black&labelColor=e84118)
![AUR Maintainer](https://img.shields.io/aur/maintainer/claude-desktop-native?style=for-the-badge&logo=github&logoColor=white&color=black&labelColor=2c3e50)
![AUR Last Modified](https://img.shields.io/aur/last-modified/claude-desktop-native?style=for-the-badge&logo=linux&logoColor=lime&color=black&labelColor=5f27cd)

> **Note**: This is a community-maintained package and is not affiliated with Anthropic. Use at your own risk.

## Overview

This unofficial AUR package brings Claude Desktop to Arch Linux natively, allowing you to use Anthropic's AI assistant with MCP servers on your Linux machine without virtualization or emulation.

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
- Preserves all functionality of the official Claude Desktop application (including MCP support)
- Seamless desktop environment integration (icons, shortcuts, etc.)
- Transparent implementation with no additional telemetry

## Implementation

The project works by:

1. Obtaining the official Windows executable
2. Extracting the application from the Windows executable
3. Replacing Windows-specific native bindings with Linux-compatible alternatives
4. Repackaging everything to work with the system's Electron installation

The core functionality is provided by `patchy-cnb`, which implements Linux versions of the `claude-native-bindings` that Claude Desktop expects.

## Technical Documentation

### File Structure

After installation, files are organized as follows:

```plaintext
/usr/
├── bin/
│   └── claude-desktop-native
├── lib/
│   └── claude-desktop-native/
│       ├── app.asar
│       ├── app.asar.unpacked
│       │   └── node_modules
│       │       └── claude-native
│       │           └── claude-native-binding.node
│       └── resources/
│           ├── de-DE.json
│           ├── en-US.json
│           ├── en-XA.json
│           ├── en-XB.json
│           ├── es-419.json
│           ├── es-ES.json
│           ├── fr-FR.json
│           ├── hi-IN.json
│           ├── id-ID.json
│           ├── it-IT.json
│           ├── ja-JP.json
│           ├── ko-KR.json
│           ├── pt-BR.json
│           ├── TrayIconTemplate@2x.png
│           ├── TrayIconTemplate@3x.png
│           ├── TrayIconTemplate-Dark@2x.png
│           ├── TrayIconTemplate-Dark@3x.png
│           ├── TrayIconTemplate-Dark.png
│           ├── TrayIconTemplate.png
│           ├── Tray-Win32-Dark.ico
│           ├── Tray-Win32.ico
│           ├── xx-AC.json
│           ├── xx-HA.json
│           └── xx-LS.json
└── share/
    └── icons/
        └── hicolor/
            ├── 16x16
            │   └── apps/
            │       └── claude.png
            ├── 24x24
            │   └── apps/
            │       └── claude.png
            ├── 256x256
            │   └── apps/
            │       └── claude.png
            ├── 32x32
            │   └── apps/
            │       └── claude.png
            ├── 48x48
            │   └── apps/
            │       └── claude.png
            └── 64x64
                └── apps/
                    └── claude.png
```

All libraries and resources are stored in `/usr/lib/claude-desktop-native` to ensure compatibility with the system's Electron installation.
All icons are stored in `/usr/share/icons/hicolor` for desktop environment integration.
The binary is symlinked to `/usr/bin/claude-desktop-native` for easy access.

- The binary is just a wrapper script that executes `exec electron /usr/lib/claude-desktop-native/app.asar "$@"`.

### Build Process

The package build follows these steps:

1. **Download Phase**:

   - Fetches the official Windows installer (.exe)
   - Fetches the patchy-cnb library source code
   - Verifies checksum to ensure integrity

2. **Extraction Phase**:

   - Uses `7z` to extract `Claude-Setup-x64.exe`
   - Uses `7z` to extract the `AnthropicClaude-${pkgver}-full.nupkg` package
   - Uses `asar` to extract the `app.asar` file which contains the Electron application

3. **Patching Phase**:

   - Builds the `patchy-cnb` library from source using Rust
   - Replaces Windows-specific `.node` native modules with the newly compiled `patchy-cnb` ones
   - Replaces the `kIe()` and `qD()` functions of the `.vite/build/index.js` with ones that simply return the absolute path of the resources folder within the applications directory

4. **Packaging Phase**:
   - Organizes files into the proper directory structure
   - Creates desktop integration files (icons, launchers)
   - Sets up the executable wrapper to use the system's Electron

### Native Binding Replacement

The critical part of the process is replacing Windows-native `.node` files with Linux-compatible alternatives:

1. Windows-specific native modules (`*.node`) are identified in the application
2. These are typically used for:
   - System integration
   - Clipboard operations
   - Window management
   - Notification handling
3. The `patchy-cnb` library provides compatible implementations of these functions for Linux
4. During build, the Windows `.node` files are replaced with the newly compiled Linux versions

### Configuration

MCP configuration is handled in `$XDG_CONFIG_DIRS/Claude/claude_desktop_config.json`.

### Debugging

For troubleshooting, you can:

1. Run the application from terminal to see output:

   ```bash
   ELECTRON_ENABLE_LOGGING=1 claude-desktop-native
   ```

2. Inspect logs in:

   ```
   ~/.local/share/claude-desktop-native/logs/
   ```

3. Verify native binding loading by checking:

   ```bash
   ldd /usr/share/claude-desktop-native/app.asar.unpacked/node_modules/@anthropic-ai/patchy-cnb/patchy-cnb.node
   ```

Native modules are intentionally installed without execution permissions as they are loaded directly by Node.js using dlopen(), which only requires read access.

## Dependencies

- electron (runtime)
- cargo (make)
- icoutils (make)
- imagemagick (make)
- nodejs (make)
- npm (make)
- p7zip (make)
- rust (make)
- tar (make)
- docker (optional) – for running MCP servers

## Community Projects

Similar community-maintained packages for other distributions:

### NixOS

- [k3d3/claude-desktop-linux-flake](https://github.com/k3d3/claude-desktop-linux-flake) - Original implementation

### Debian

- [aaddrick/claude-desktop-debian](https://github.com/aaddrick/claude-desktop-debian) - Seeking new maintainer

### Ubuntu

- [hanpham32/claude-desktop-linux-installer](https://github.com/hanpham32/claude-desktop-linux-installer)

## Troubleshooting

| Issue                   | Solution                                              |
| ----------------------- | ----------------------------------------------------- |
| Blank screen on startup | Verify Electron version compatibility                 |
| Authentication fails    | Check account credentials and internet connection     |
| Missing icons           | Verify the icons were installed in `/usr/share/icons` |
|                         | Restart your computer or log out and back in          |

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

