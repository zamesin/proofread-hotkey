# Proofread Hotkey

A small free app for Mac. You press one keyboard shortcut in any app, and your own Claude or Codex fixes the English in your text. (Codex is the same kind of assistant from OpenAI; it works on a ChatGPT subscription.) A small window in the top-right corner shows what was changed and why, so you learn from every fix.

[Читать по-русски](README.ru.md)

![The window with the corrected text, the list of changes and the original text](docs/window.png)

## What happens when you press the shortcut

1. You write a text anywhere: in a browser, in Slack, in Mail, in a chat.
2. You copy the text (Command + C) and press **Command + Shift + ;** (the key with the semicolon). If you let the app press Command + C for you (see "Select the text instead of copying it"), you only select the text and press the shortcut.
3. The app gives the text to Claude or Codex. It uses the program that is already installed on your Mac and signed in with your account, so it works on your existing subscription. You do not need a separate paid developer account, and you do not pay per request.
4. While the check runs, a small window in the top-right corner of the screen says "Checking with Claude…" and shows your text. The check takes 4 to 10 seconds.
5. Then the corrected text is in your clipboard. You paste it (Command + V) wherever you want. The app never pastes, sends or publishes anything by itself.
6. The window now shows three things:
   - the corrected text, where every new word has a green background;
   - the list "What changed": what you wrote, what it became, and a short reason, for example *“asap” → “ASAP”. Acronyms are written in capitals*;
   - your original text, where every replaced word has a red background.

   If the text has no mistakes, the window says "No edits needed — copied".
7. The window closes by itself after 5 seconds. A small ring in its top-right corner shows how much time is left. Put the mouse pointer over the window and the ring stops: the window stays while you read. Move the pointer away and the countdown goes on. A click on the window closes it at once.

The window never becomes the active window. What you type still goes to the app you work in.

The explanations are in English. You can change the language, see "Change the rules of proofreading".

## What you need

- A Mac with macOS 13 or newer.
- One of these two programs. Both are programs that you use by typing in the Terminal app, and each works on a subscription you may already have:
  - **Claude Code** from Anthropic (the `claude` command). It works with a Claude Pro or Max subscription. Install it from https://claude.com/claude-code
  - **Codex CLI** from OpenAI (the `codex` command). It works with a ChatGPT subscription. Install it from https://github.com/openai/codex

After the install, sign in once. Open the Terminal app: press Command + Space, type "Terminal", press Return. Type `claude` (or `codex`), press Return and follow the steps on the screen: the program asks you to sign in with the account that has your subscription.

If you have both programs, the app uses Claude. You can switch in the app's menu.

## Install: ask your Claude to do it

1. Open the Terminal app: press Command + Space, type "Terminal", press Return.
2. Type `claude` (or `codex`) and press Return.
3. Paste this message and press Return:

```
Install Proofread Hotkey on my Mac: clone https://github.com/zamesin/proofread-hotkey and follow the AGENTS.md file in it.
```

Claude downloads the files into the folder `proofread-hotkey` in your home folder, installs the app, starts it, checks that it works and tells you what to do next. This takes about a minute. Claude may ask for your permission to run commands: allow them.

## Install: do it yourself

Open the Terminal app (press Command + Space, type "Terminal", press Return). Paste these three lines one by one, and press Return after each line:

```
git clone https://github.com/zamesin/proofread-hotkey.git ~/proofread-hotkey
cd ~/proofread-hotkey
./install.sh
```

If macOS offers to install the "command line developer tools" after the first line, agree, wait until the install ends, and paste the first line again.

The third line puts **Proofread Hotkey** into your Applications folder and starts it.

## Check that it works

After the install you see a new icon in the menu bar at the top of the screen: lines of text with a check mark. Copy any English text, press Command + Shift + ; and look at the top-right corner of the screen. The window with the corrected text appears there.

## Select the text instead of copying it

Right after the install the order is: you copy the text, then you press the shortcut. To skip the copying, let the app press Command + C for you:

1. Click the app's icon in the menu bar.
2. Choose **Take the selected text without ⌘C: allow…** (⌘ is the Command key).
3. macOS opens System Settings → Privacy & Security → Accessibility. Turn on the switch next to Proofread Hotkey.

Now you select a text and press the shortcut. If the app still checks the old text, choose **Quit** in its menu and open Proofread Hotkey from the Applications folder again.

The app needs this permission only to press Command + C in the active window. Without the permission everything else works the same.

## The menu

Click the icon in the menu bar to see the menu:

- **Proofread** — the same as the shortcut.
- **Show the last changes** — opens the last window again, if 5 seconds were not enough.
- **Hotkey: ⇧⌘;. Change…** — a small window appears. Press the new shortcut in it: two keys such as Command + Shift or Control + Option, plus one more key. The new shortcut replaces Command + Shift + ;.
- **Checks with** — choose Claude or Codex.
- **Edit the prompt…** — opens the text of the rules that the app gives to Claude or Codex. See the next section.
- **Start at login** — the app starts by itself when you turn on the Mac. It is on after the install.
- **Quit**.

## Change the rules of proofreading

The app gives Claude or Codex a text with rules: fix grammar, spelling and unnatural phrases; keep the meaning, the tone and the line breaks; translate words from another language that are mixed into an English text; explain every edit in plain English.

To change the rules, choose **Edit the prompt…** in the app's menu. A file with the rules opens in TextEdit. Edit it and save. The next check uses the new text. For example, you can ask for British English, or for explanations in your own language.

The last paragraphs of the file tell Claude to answer in two parts: first the corrected text, then a line `===CHANGES===`, then the list of changes. Do not change these paragraphs. Without them the app cannot show the list "What changed".

To go back to the built-in rules, delete the file: in Finder choose Go → Go to Folder…, paste `~/Library/Application Support/Proofread Hotkey`, press Return and move `prompt.txt` to the Trash.

## Privacy

- Your text goes only to the Claude or Codex program on your Mac, and from it to Anthropic or OpenAI under your own account, the same as when you use these programs yourself.
- The app has no server and collects nothing.
- The app starts Claude or Codex in a mode where it cannot open your files or run commands. It only reads the text you sent and answers.
- The app keeps a log file, `~/Library/Logs/ProofreadHotkey.log`. It holds technical lines only: the time, the length of the text, how long the check took. It does not hold your texts.

## Update and uninstall

To update, open the Terminal app and paste these lines one by one, with Return after each:

```
cd ~/proofread-hotkey
git pull
./install.sh
```

After an update macOS may forget that you let the app press Command + C. Open System Settings → Privacy & Security → Accessibility, select the Proofread Hotkey line and remove it with the minus button. Then choose **Take the selected text without ⌘C: allow…** in the app's menu again.

To uninstall: choose **Quit** in the app's menu and move Proofread Hotkey from the Applications folder to the Trash. Two things stay on the disk, and you can delete them too: the folder `proofread-hotkey` in your home folder and, if you changed the rules, the file `prompt.txt` from the previous section.

## If something does not work

- **Nothing happens when I press the shortcut.** Check that the icon is in the menu bar. If it is not, open Proofread Hotkey from the Applications folder. If the icon is there, another app may use the same shortcut: choose another one in the menu.
- **The window says that `claude` or `codex` was not found.** Install Claude Code or Codex CLI and sign in, as the section "What you need" says. Then press the shortcut again.
- **The window says that Claude or Codex could not check the text.** Open the Terminal app, type `claude` (or `codex`) and press Return. You will see whether you are signed in and whether your subscription is active.
- **The app checked an old text.** You pressed the shortcut without copying the new text. Copy first, or let the app press Command + C for you: menu item **Take the selected text without ⌘C: allow…**
- **The window says that the text is too long.** The app takes texts up to 6000 characters. Check a longer text in parts.

## License

MIT. See [LICENSE](LICENSE).
