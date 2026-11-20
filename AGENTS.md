# Instructions for an AI agent (Claude Code, Codex) that installs Proofread Hotkey

The person asked you to install this app on their Mac. Do every step below yourself, in order. Ask the person only where a step says so. At the end, tell them the short message from the last step.

Proofread Hotkey is a macOS menu-bar app: a global keyboard shortcut sends the copied (or selected) text to the Claude Code CLI or the Codex CLI that is already signed in on this Mac, puts the corrected text into the clipboard and shows a small window with the list of edits. What it does and how it looks is described in `README.md`.

## Steps

1. **Check the system.** `sw_vers -productVersion` must be 13 or newer. If it is older, or this is not a Mac, stop and tell the person that the app cannot run here.

2. **Get the code.** If you are not inside a clone of this repository yet, clone it to a permanent place, not to a temporary folder (updates are pulled there later):
   `git clone https://github.com/zamesin/proofread-hotkey.git ~/proofread-hotkey`
   If `xcode-select -p` fails, this Mac has no Xcode Command Line Tools and `git` would only open an install dialog. Do not start that install. Download the code without git instead:
   `mkdir -p ~/proofread-hotkey` and then `curl -fsSL https://github.com/zamesin/proofread-hotkey/archive/refs/heads/main.tar.gz | tar -xz --strip-components 1 -C ~/proofread-hotkey`
   (To update such a copy later, run the same `curl` command again and then `./install.sh`.)

3. **Install.** Run `./install.sh` in the repository folder. It builds the app from `Sources/` when the Xcode Command Line Tools are present (about 30 seconds), otherwise it downloads the ready app from GitHub Releases. Then it copies `Proofread Hotkey.app` to `/Applications` (or `~/Applications`), starts it and prints which of the two CLIs it found. Do not use `sudo`.

4. **Check that an engine is ready.** The app needs at least one of: `claude` (Claude Code) or `codex` (Codex CLI), signed in.
   - You are one of them, so at least that one is installed.
   - Read the app's start line: `tail -5 ~/Library/Logs/ProofreadHotkey.log`. It must contain `enginesFound=[...]` with at least one name and `hotkey … register status=0`.
   - If `status` is not 0, another app holds the shortcut. Tell the person to pick another one: menu-bar icon → "Hotkey… Change…".
   - The app uses Claude when both are found. To choose the engine for the person: `defaults write io.github.zamesin.proofread-hotkey engine codex` (or `claude`).

5. **Test it for real.** This runs one proofreading through the person's subscription and overwrites their clipboard, which is fine at install time:
   - `printf '%s' "me and him goes to school yesterday" | pbcopy`
   - Trigger the same code as the shortcut (the app listens for this notification):
     `osascript -l JavaScript -e 'ObjC.import("Foundation"); $.NSDistributedNotificationCenter.defaultCenter.postNotificationNameObjectUserInfoDeliverImmediately("io.github.zamesin.proofread-hotkey.run", $(), $(), true)'`
   - Wait up to 60 seconds, checking `tail -5 ~/Library/Logs/ProofreadHotkey.log`. Success is a line `engine=… exit=0` followed by `toast shown state=result`, and `pbpaste` printing a corrected sentence such as "He and I went to school yesterday."
   - If the log shows `toast shown state=message` instead, the engine failed. The line `engine error: …` above it has the reason. The usual reason is that the CLI is not signed in: tell the person to run `claude` (or `codex login`) in a terminal and sign in, then repeat this step.

6. **Offer the one optional permission.** Ask the person: "Do you want to select a text and press the shortcut, without copying it first? This needs the Accessibility permission." If yes, tell them: click the app's icon in the menu bar → "Take the selected text without ⌘C: allow…" → turn on the switch next to Proofread Hotkey in System Settings. You cannot grant this permission for them.

7. **Tell the person, in their language, briefly:**
   - The app is installed and runs; its icon (lines of text with a check mark) is in the menu bar.
   - How to use it: copy a text, press Command + Shift + ; , paste the corrected text. The window in the top-right corner shows what changed and closes after 5 seconds; it stays while the mouse pointer is over it.
   - Which engine it uses (Claude or Codex), and that it can be changed in the menu.
   - The shortcut and the proofreading rules can be changed in the menu ("Hotkey… Change…", "Edit the prompt…").

## Useful facts

- Settings live in `defaults` under `io.github.zamesin.proofread-hotkey`: `engine` (`claude` | `codex`), `claudeModel` (default `sonnet`), `codexModel` (default: the Codex default model).
- The person's own proofreading rules: `~/Library/Application Support/Proofread Hotkey/prompt.txt`. If the person wants other rules (for example explanations in their language), create or edit this file. Start from the built-in text: it is `defaultPrompt` in `Sources/main.swift`. Keep the two-part answer format with the `===CHANGES===` line.
- Update: `git pull` in the repository folder, then `./install.sh`. The build is signed ad hoc, so after an update the Accessibility permission must be given again (remove the old line in System Settings → Privacy & Security → Accessibility, then allow again from the app's menu).
- Uninstall: `pkill -x ProofreadHotkey`, delete the app from `/Applications` (or `~/Applications`), and optionally `defaults delete io.github.zamesin.proofread-hotkey`.
- Never paste, send or publish the corrected text for the person. The app only puts it into the clipboard.
