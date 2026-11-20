#!/bin/zsh
# Builds "Proofread Hotkey.app" into ./build (universal: Apple Silicon + Intel). Needs the Xcode Command Line Tools.
# Signing: ad-hoc by default. To sign with your own certificate: SIGN_IDENTITY="Apple Development: …" ./build.sh
set -euo pipefail
DIR="${0:A:h}"
APP="$DIR/build/Proofread Hotkey.app"

rm -rf "$DIR/build"
mkdir -p "$APP/Contents/MacOS"
for arch in arm64 x86_64; do
  swiftc -O -target "$arch-apple-macos13" -o "$DIR/build/bin-$arch" "$DIR"/Sources/*.swift -framework AppKit -framework Carbon -framework ServiceManagement
done
lipo -create "$DIR/build/bin-arm64" "$DIR/build/bin-x86_64" -output "$APP/Contents/MacOS/ProofreadHotkey"
rm "$DIR/build/bin-arm64" "$DIR/build/bin-x86_64"
cp "$DIR/Info.plist" "$APP/Contents/Info.plist"
codesign --force --sign "${SIGN_IDENTITY:--}" "$APP"
echo "Built: $APP"
