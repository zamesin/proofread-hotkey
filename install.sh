#!/bin/zsh
# Installs Proofread Hotkey into /Applications (or ~/Applications when /Applications is not writable) and starts it.
# With the Xcode Command Line Tools it builds from the source in this folder; without them it downloads the ready app from GitHub Releases.
set -euo pipefail
DIR="${0:A:h}"
NAME="Proofread Hotkey.app"
REPO="zamesin/proofread-hotkey"

if [[ "$(uname)" != "Darwin" ]]; then echo "Proofread Hotkey works on macOS only."; exit 1; fi
if [[ "$(sw_vers -productVersion | cut -d. -f1)" -lt 13 ]]; then echo "Proofread Hotkey needs macOS 13 or newer."; exit 1; fi

if xcode-select -p >/dev/null 2>&1 && xcrun --find swiftc >/dev/null 2>&1; then
  "$DIR/build.sh"
else
  echo "No Xcode Command Line Tools: downloading the ready app."
  rm -rf "$DIR/build"
  mkdir -p "$DIR/build"
  curl -fsSL "https://github.com/$REPO/releases/latest/download/ProofreadHotkey.zip" -o "$DIR/build/ProofreadHotkey.zip"
  ditto -x -k "$DIR/build/ProofreadHotkey.zip" "$DIR/build"
fi

DEST="/Applications"
if [[ ! -w "$DEST" ]]; then DEST="$HOME/Applications"; mkdir -p "$DEST"; fi
pkill -x ProofreadHotkey 2>/dev/null || true
for i in {1..20}; do pgrep -x ProofreadHotkey >/dev/null || break; sleep 0.2; done # the new copy quits if the old one is still alive
rm -rf "$DEST/$NAME"
ditto "$DIR/build/$NAME" "$DEST/$NAME"
/usr/bin/open "$DEST/$NAME"

echo "Installed and started: $DEST/$NAME"
echo "Log: ~/Library/Logs/ProofreadHotkey.log"
for cli in claude codex; do
  if zsh -lic "command -v $cli" >/dev/null 2>&1; then echo "Found: $cli"; else echo "Not found: $cli"; fi
done
