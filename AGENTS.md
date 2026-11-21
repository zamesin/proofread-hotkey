# Instructions for an AI agent (Claude Code, Codex) that installs Proofread Hotkey

The person asked you to install this app on their Mac. Do every step below yourself, in order. Ask the person only where a step says so. At the end, tell them the short message from the last step.

Proofread Hotkey is a macOS menu-bar app: a global keyboard shortcut sends the selected (or copied) text to the Claude Code CLI or the Codex CLI that is already signed in on this Mac, puts the corrected text in place of the selection (if it has not changed) and into the clipboard, and shows a small window with the list of edits. What it does and how it looks is described in `README.md`.

## Steps

1. **Check the system.** `sw_vers -productVersion` must be 13 or newer. If it is older, or this is not a Mac, stop and tell the person that the app cannot run here.

2. **Get the code.** If you are not inside a clone of this repository yet, clone it to a permanent place, not to a temporary folder (updates are pulled there later):
   `git clone https://github.com/zamesin/proofread-hotkey.git ~/proofread-hotkey`
   If `xcode-select -p` fails, this Mac has no Xcode Command Line Tools and `git` would only open an install dialog. Do not start that install. Download the code without git instead:
   `mkdir -p ~/proofread-hotkey` and then `curl -fsSL https://github.com/zamesin/proofread-hotkey/archive/refs/heads/main.tar.gz | tar -xz --strip-components 1 -C ~/proofread-hotkey`
   (To update such a copy later, run the same `curl` command again and then `./install.sh`.)

3. **Install.** Run `install.sh` from the repository folder; the absolute path works from any folder, for example `~/proofread-hotkey/install.sh`. It builds the app from `Sources/` when the Xcode Command Line Tools are present (about 30 seconds), otherwise it downloads the ready app from GitHub Releases. Then it copies `Proofread Hotkey.app` to `/Applications` (or `~/Applications`), starts it and prints which of the two CLIs it found. On its first start the app also turns on "Start at login" for itself; the person can turn it off in the app's menu. Do not use `sudo`.

4. **Check that an engine is ready.** The app needs at least one of: `claude` (Claude Code) or `codex` (Codex CLI), signed in.
   - You are one of them, so at least that one is installed.
   - Wait 5 seconds after the install (the app first looks up the PATH of the login shell), then read the app's start line: `tail -5 ~/Library/Logs/ProofreadHotkey.log`. It must contain `enginesFound=[...]` with at least one name and `hotkey … register status=0`.
   - If `status` is not 0, another app holds the shortcut. Tell the person to pick another one: menu-bar icon → "Hotkey… Change…".
   - The app uses Claude when both are found. To choose the engine for the person: `defaults write io.github.zamesin.proofread-hotkey engine codex` (or `claude`).

5. **Test it for real.** This runs one proofreading through the person's subscription and overwrites their clipboard, which is fine at install time. Check first: if the start line in the log says `accessibility=true`, or the person already turned on the Accessibility switch, skip this test, because the app would then take the selection from the window in front (your terminal) instead of the clipboard. Otherwise:
   - `printf '%s' "me and him goes to school yesterday" | pbcopy`
   - Trigger the same code as the shortcut (the app listens for this notification):
     `osascript -l JavaScript -e 'ObjC.import("Foundation"); $.NSDistributedNotificationCenter.defaultCenter.postNotificationNameObjectUserInfoDeliverImmediately("io.github.zamesin.proofread-hotkey.run", $(), $(), true)'`
   - Wait up to 60 seconds, checking `tail -5 ~/Library/Logs/ProofreadHotkey.log`. Success is a line `engine=… exit=0` followed by `toast shown state=result`, and `pbpaste` printing a corrected sentence such as "He and I went to school yesterday."
   - If the log shows `toast shown state=message` instead, the engine failed. The log has only `engine error: exit=…`; to see the reason, run the CLI yourself, for example `echo hi | claude -p`. The usual reason is that the CLI is not signed in: tell the person to run `claude` (or `codex login`) in a terminal and sign in, then repeat this step.

6. **Explain the one optional permission.** On its first start the app asked macOS for the Accessibility permission, so the person may already see a macOS window about it. With the permission they select a text, press the shortcut, and the corrected text replaces the selection. Without it they copy the text, press the shortcut and paste the fix themselves. If they want it, tell them: turn on the switch next to Proofread Hotkey in System Settings → Privacy & Security → Accessibility (if the macOS window is gone: click the app's icon in the menu bar → "Take the selected text and paste the fix: allow…"). You cannot grant this permission for them. Do not test the paste yourself: it presses Command + C and Command + V in whatever window the person is working in.

7. **Tell the person, in their language, briefly:**
   - The app is installed and runs; its icon (lines of text with a check mark) is in the menu bar.
   - How to use it: with the permission, select a text and press Command + Shift + ; — the corrected text replaces the selection. Without the permission, copy a text, press the shortcut and paste the corrected text. The window in the top-right corner shows what changed and closes after 5 seconds; it stays while the mouse pointer is over it.
   - Which engine it uses (Claude or Codex), and that it can be changed in the menu.
   - The app now starts by itself when they log in to the Mac; "Start at login" in the menu turns this off.
   - The shortcut and the proofreading rules can be changed in the menu ("Hotkey… Change…", "Edit the prompt…").

## Useful facts

- Settings live in `defaults` under `io.github.zamesin.proofread-hotkey`: `engine` (`claude` | `codex`), `claudeModel` (default `sonnet`), `codexModel` (default: the Codex default model).
- The person's own proofreading rules: `~/Library/Application Support/Proofread Hotkey/prompt.txt`. If the person wants other rules (for example explanations in their language), create or edit this file. Start from the built-in text: it is `defaultPrompt` in `Sources/main.swift`. Keep the two-part answer format with the `===CHANGES===` line.
- Update: `git pull` in the repository folder, then `./install.sh`. The build is signed ad hoc, so after an update the Accessibility permission must be given again (remove the old line in System Settings → Privacy & Security → Accessibility, then allow again from the app's menu).
- Uninstall, in this order: first `"/Applications/Proofread Hotkey.app/Contents/MacOS/ProofreadHotkey" --remove-login-item` (macOS keeps the "start at login" record after the app is deleted, so remove it while the app still exists), then `pkill -x ProofreadHotkey`, then delete the app from `/Applications` (or `~/Applications`), and optionally `defaults delete io.github.zamesin.proofread-hotkey`.
- Never send or publish the corrected text for the person. The app only replaces the selected text in the field (when the same text is still selected in the same app) and puts the corrected text into the clipboard; it never presses Return or a send button.
