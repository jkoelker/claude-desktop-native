# Maintainer: AstroSteveO <stevengmjr at gmail dot com>

pkgname=claude-desktop-native
pkgver=0.12.28
pkgrel=1
pkgdesc="Unofficial Claude Desktop for Linux"
arch=('x86_64')
url="https://github.com/claude-desktop-native/claude-desktop-native.git"
license=('MIT' 'Apache')
depends=('electron')
makedepends=('p7zip' 'npm' 'nodejs' 'rust' 'cargo' 'imagemagick' 'icoutils' 'tar')
optdepends=('docker: for running MCP servers')
source=("Claude-Setup-x64.exe::https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest-win-x64/Claude-Setup-x64.exe"
  "patchy-cnb-1.0.0.tar.gz::https://github.com/claude-desktop-native/patchy-cnb/archive/refs/tags/v1.0.0.tar.gz")
sha256sums=('e6932fe8bac63af4171009d612d1ddf7ff616736749808b4fd8519364c3f01b6'
  'c5bba36cf5d076f61dec3ade072eb61a62818fa2f1584e88cbe8ef775776ca83')

prepare() {
  cd "${srcdir}"

  # Extract the patchy-cnb library
  echo "Extracting patchy-cnb..."
  tar -xzf "patchy-cnb-1.0.0.tar.gz"

  # Extract installer exe and nupkg
  7z x -y "Claude-Setup-x64.exe"
  7z x -y "AnthropicClaude-${pkgver}-full.nupkg"

  # Verify version matches what's in the nuspec file
  if [ -f "AnthropicClaude.nuspec" ]; then
    NUSPEC_VERSION=$(grep -oP '<version>\K[^<]+' "AnthropicClaude.nuspec")
    if [ "$NUSPEC_VERSION" != "$pkgver" ]; then
      echo "WARNING: PKGBUILD version ($pkgver) does not match nuspec version ($NUSPEC_VERSION)"
      echo "Please update pkgver in PKGBUILD to: $NUSPEC_VERSION"
    fi
  fi

  # Extract icons from claude.exe
  wrestool -x -t 14 lib/net45/claude.exe -o claude.ico
  icotool -x claude.ico

  mkdir -p icons/hicolor
  for size in 16 24 32 48 64 256; do
    mkdir -p "icons/hicolor/${size}x${size}/apps"
    install -Dm 644 claude_*"${size}x${size}x32.png" \
      "icons/hicolor/${size}x${size}/apps/claude.png"
  done
}

build() {
  # Build patchy-cnb (assuming patchy-cnb folder exists at same level as PKGBUILD)
  cd "${srcdir}/patchy-cnb-1.0.0"
  npm install
  npm run build
  cd "${srcdir}"

  # Process app.asar files
  mkdir -p electron-app
  cp "lib/net45/resources/app.asar" electron-app/
  cp -r "lib/net45/resources/app.asar.unpacked" electron-app/

  cd electron-app
  npx asar extract app.asar app.asar.contents
  sed -i 's|return ..app.isPackaged?.*resolve(__dirname,"..","..","resources")|return "/usr/lib/'"${pkgname}"'/resources"|' app.asar.contents/.vite/build/index*.js
  # note that the below is replacing i18n with the standard resources directory as that's where the i18n json files wind up
  sed -i 's|return ..app.isPackaged?.*resolve(__dirname,"..","..","resources","i18n")|return "/usr/lib/'"${pkgname}"'/resources"|' app.asar.contents/.vite/build/index*.js
  # fix negation operator to show menubar
  sed -i -E 's/if\(!([a-zA-Z]+)[[:space:]]*&&[[:space:]]*([a-zA-Z]+)\)/if(\1 \&\& \2)/g' app.asar.contents/.vite/renderer/main_window/assets/MainWindowPage-*.js

  # Replace native bindings with patchy-cnb
  pwd
  local PATCHY_CNB_NODE=$(find ../patchy-cnb-1.0.0 -name "patchy-cnb.*.node")
  cp "${PATCHY_CNB_NODE}" app.asar.contents/node_modules/claude-native/claude-native-binding.node
  cp "${PATCHY_CNB_NODE}" app.asar.unpacked/node_modules/claude-native/claude-native-binding.node

  # Add Tray icons to app resources
  mkdir -p app.asar.contents/resources
  cp ../lib/net45/resources/Tray* app.asar.contents/resources/

  # Copy i18n json files
  mkdir -p app.asar.contents/resources/i18n
  cp ../lib/net45/resources/*.json app.asar.contents/resources/i18n/

  # Repackage app.asar
  npx asar pack app.asar.contents app.asar
}

package() {
  cd "${srcdir}"

  # Install app files
  install -d "${pkgdir}/usr/lib/${pkgname}"
  cp -r electron-app/app.asar "${pkgdir}/usr/lib/${pkgname}/"
  cp -r electron-app/app.asar.unpacked "${pkgdir}/usr/lib/${pkgname}/"

  # Install resources directory with tray icons
  install -d "${pkgdir}/usr/lib/${pkgname}/resources"
  cp electron-app/app.asar.contents/resources/Tray* "${pkgdir}/usr/lib/${pkgname}/resources/"

  # Copy language JSON files to resources directory
  cp lib/net45/resources/*.json "${pkgdir}/usr/lib/${pkgname}/resources/"

  # Install icons
  install -d "${pkgdir}/usr/share/icons"
  cp -r icons/* "${pkgdir}/usr/share/icons/"

  # Create desktop file
  install -Dm644 /dev/stdin "${pkgdir}/usr/share/applications/${pkgname}.desktop" <<EOF
[Desktop Entry]
Name=Claude
GenericName=Claude Desktop
Exec=${pkgname} %u
Icon=${pkgname}
Type=Application
Terminal=false
Categories=Office;Utility;
MimeType=x-scheme-handler/claude;
StartupWMClass=Claude
EOF

  # Create launcher script
  install -Dm755 /dev/stdin "${pkgdir}/usr/bin/${pkgname}" <<EOF
#!/bin/sh
exec electron /usr/lib/${pkgname}/app.asar --gtk-version=3 "\$@"
EOF
}
