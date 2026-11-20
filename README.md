# Proofread Hotkey

A small free app for Mac. You press one keyboard shortcut in any app, and your own Claude or Codex fixes the English in your text. A small window in the top-right corner shows what was changed and why, so you learn from every fix.

[Читать по-русски](README.ru.md)

![The window with the corrected text, the list of changes and the original text](docs/window.png)

## What happens when you press the shortcut

1. You write a text anywhere: in a browser, in Slack, in Mail, in a chat.
2. You copy the text (Command + C) and press **Command + Shift + ;** (the key with the semicolon). If you give the app one permission, described below, you can skip the copying: you select the text and press the shortcut.
3. The app sends the text to Claude or Codex. It uses the command-line program that is already installed and signed in on your Mac, so it works on your existing subscription. You do not need an API key and you do not pay per request.
4. In a few seconds the corrected text is in your clipboard. You paste it (Command + V) wherever you want. The app never pastes, sends or publishes anything by itself.
5. A small window appears in the top-right corner of the screen. It shows three things:
   - the corrected text, where every new word has a green background;
   - the list "What changed": what you wrote, what it became, and a short reason, for example *“asap” → “ASAP”. Acronyms are written in capitals*;
   - your original text, where every replaced word has a red background.
6. The window closes by itself after 5 seconds. A small ring in its top-right corner shows how much time is left. Put the mouse pointer over the window and the ring stops: the window stays while you read. Move the pointer away and the countdown goes on. A click on the window closes it at once.

The window never takes the keyboard or the focus away from the app you work in. You can keep typing while it is on the screen.

## What you need

- A Mac with macOS 13 or newer.
- One of these two programs, installed and signed in with your subscription:
  - **Claude Code** — the command-line program from Anthropic (the `claude` command). It works with a Claude Pro or Max subscription.
  - **Codex CLI** — the command-line program from OpenAI (the `codex` command). It works with a ChatGPT subscription.

If you have both, the app uses Claude. You can switch in the app's menu.

## Install: ask your Claude to do it

Open Claude Code (or Codex) in the terminal and paste this message:

```
Install Proofread Hotkey on my Mac: clone https://github.com/zamesin/proofread-hotkey and follow the AGENTS.md file in it.
```

Claude downloads the app, installs it, starts it, checks that it works and tells you what to do next. This takes about a minute.

## Install: do it yourself

Open the Terminal app and run these three commands:

```
git clone https://github.com/zamesin/proofread-hotkey.git ~/proofread-hotkey
cd ~/proofread-hotkey
./install.sh
```

The script puts **Proofread Hotkey** into your Applications folder and starts it. If the Xcode Command Line Tools are on your Mac, the script builds the app from the source code in the folder. If they are not, it downloads the ready app from this repository's Releases page.

After the start you see a new icon in the menu bar at the top of the screen: lines of text with a check mark. Copy any English text, press Command + Shift + ; and look at the top-right corner of the screen.

## Select the text instead of copying it

By default you copy the text first, then press the shortcut. To skip the copying, let the app press Command + C for you:

1. Click the app's icon in the menu bar.
2. Choose **Take the selected text without ⌘C: allow…**
3. macOS opens System Settings → Privacy & Security → Accessibility. Turn on the switch next to Proofread Hotkey.

Now you select a text and press the shortcut. The app needs this permission only to press Command + C in the active window. Without the permission everything else works the same.

## The menu

Click the icon in the menu bar to see the menu:

- **Proofread** — the same as the shortcut.
- **Show the last changes** — opens the last window again, if 5 seconds were not enough.
- **Hotkey… Change…** — press any other shortcut to use it instead of Command + Shift + ;.
- **Checks with** — choose Claude or Codex.
- **Edit the prompt…** — opens the text of the rules that the app gives to Claude or Codex. See the next section.
- **Start at login** — the app starts by itself when you turn on the Mac. It is on after the install.
- **Quit**.

## Change the rules of proofreading

The app gives Claude or Codex a text with rules: fix grammar, spelling and unnatural phrases, keep the meaning, the tone and the line breaks, translate words from another language that are mixed into an English text, explain every edit in plain English.

To change the rules, choose **Edit the prompt…** in the menu. The file `~/Library/Application Support/Proofread Hotkey/prompt.txt` opens in TextEdit. Edit it and save. The next check uses the new text. For example, you can ask for British English, or for explanations in your own language.

Keep the part about the two parts of the answer and the line `===CHANGES===`: the app needs it to show the list "What changed". To go back to the built-in rules, delete the file.

## Privacy

- Your text goes only to the Claude or Codex program on your Mac, and from it to Anthropic or OpenAI under your own account, the same as when you use these programs yourself.
- The app has no server and collects nothing.
- The app runs Claude or Codex with tools turned off, in an empty temporary folder: the model only reads the text and answers.
- The log file `~/Library/Logs/ProofreadHotkey.log` holds technical lines only: the time, the length of the text, how long the check took. It does not hold your texts.

## Update and uninstall

To update, run these commands in Terminal:

```
cd ~/proofread-hotkey
git pull
./install.sh
```

After an update macOS may ask for the Accessibility permission again. In System Settings → Privacy & Security → Accessibility remove the old Proofread Hotkey line with the minus button, then turn the permission on again from the app's menu.

To uninstall: choose **Quit** in the app's menu and move Proofread Hotkey from the Applications folder to the Trash.

## If something does not work

- **Nothing happens when I press the shortcut.** Check that the icon is in the menu bar. If it is not, open Proofread Hotkey from the Applications folder. If the icon is there, another app may use the same shortcut: choose another one in the menu.
- **The window says that `claude` or `codex` was not found.** Install Claude Code or Codex CLI and sign in: open Terminal, run `claude` (or `codex login`) and follow the steps. Then press the shortcut again.
- **The window says that Claude or Codex could not check the text.** Open Terminal and run `claude` (or `codex`) to see that you are signed in and your subscription is active.
- **The app checked an old text.** You pressed the shortcut without copying the new text. Copy first, or give the permission from the section "Select the text instead of copying it".
- **The text is longer than 6000 characters.** The app does not take longer texts. Check it in parts.

## License

MIT. See [LICENSE](LICENSE).
