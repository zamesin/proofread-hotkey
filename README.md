# Proofread Hotkey

A small free app for Mac. You press one keyboard shortcut in any app, and your own Claude or Codex fixes the English in your text. (Codex is the same kind of assistant from OpenAI; it works on a ChatGPT subscription.) A small window in the top-right corner shows what was changed and why, so you learn from every fix.

You need a Claude or ChatGPT subscription and one extra free program. The section "What you need" tells how to install it.

[Читать по-русски](README.ru.md)

![The window with the corrected text, the list of changes and the original text](docs/window.png)

## What happens when you press the shortcut

1. You write a text anywhere: in a browser, in Slack, in Mail, in a chat.
2. You select the text and press **Command + Shift + ;** (the key with the semicolon). This needs the macOS permission called Accessibility. The app asks for it on its first start (see "Let the app take the selected text and paste the fix"). Without the permission the app cannot see the selected text: you copy the text first (Command + C) and then press the shortcut. If you only select the text without the permission, the app checks whatever you copied earlier. Copying first also works with the permission: when nothing is selected, the app takes the text from the clipboard. Code editors are the exception, see item 5.
3. The app gives the text to Claude or Codex. It uses Claude Code or Codex CLI. These are separate programs, not the usual Claude and ChatGPT apps, and you install one of them once (see "What you need"). The program is signed in with your account, so everything works on your existing subscription. You do not need a separate paid developer account, and you do not pay per request.
4. While the check runs, a small window in the top-right corner of the screen says "Checking with Claude…" (or "Checking with Codex…") and shows your text. The check takes 4 to 10 seconds.
5. Then the app puts the corrected text in place of the text you selected. The corrected text is also copied, the same as if you had pressed Command + C on it, so you can paste it again (Command + V) anywhere. It replaces what was in the clipboard before. The app never presses Return or a Send button and never publishes anything: it only replaces the selected text in the field, and you decide what to do with it next.

   The app does not paste, and only copies the corrected text, in these cases:
   - while the check ran, you selected another text, typed over the selection or switched to another app (so the app never overwrites what you typed during the check);
   - the text came from the clipboard: you copied it yourself and nothing was selected, or the app has no Accessibility permission;
   - in a code editor (VS Code, Cursor, JetBrains apps) when nothing was selected. The app asks such an editor to copy the selection, and with no selection these editors copy the whole current line. So the app checks that line and does not paste the fix: pasting could duplicate the line.

   Then you paste the corrected text yourself (Command + V) where you need it.

   Any text the app pastes is plain text: links and bold in the selected part become plain text. If the check fails, the window shows an error and your selected text stays untouched.
6. The window now shows three things:
   - the corrected text, where every new word has a green background;
   - the list "What changed": what you wrote, what it became, and a short reason, for example *“asap” → “ASAP”. Acronyms are written in capitals*;
   - your original text, where every replaced word has a red background.

   The bold green line at the top of the window says "Fixed and pasted" when the app replaced the selected text, and "Fixed and copied" when it only copied the corrected text. If the text has no mistakes, that line says "No edits needed — copied": the window shows only your text, your text in the field stays as it was, and the same text is put into the clipboard.
7. The window closes by itself after 5 seconds. A small ring in its top-right corner shows how much time is left. Put the mouse pointer over the window and the ring stops: the window stays while you read. Move the pointer away and the countdown goes on. A click on the window closes it at once.

The window never becomes the active window. What you type still goes to the app you work in.

The words in the app's window and menu are in English and cannot be changed. The explanations of the edits are in English too, but you can change their language, see "Change the rules of proofreading".

## What you need

- A Mac with macOS 13 or newer.
- One of these two programs. Both are programs that you use by typing in the Terminal app, and each works on a subscription you may already have:
  - **Claude Code** from Anthropic (the `claude` command). It works with a Claude Pro or Max subscription.
  - **Codex CLI** from OpenAI (the `codex` command). It works with a paid ChatGPT subscription.

To install Claude Code, open the Terminal app: press Command + Space, type "Terminal", press Return. Paste this line and press Return:

```
curl -fsSL https://claude.ai/install.sh | bash
```

Wait until the Terminal says that the install is finished. If the line does not work, the current instructions are on https://claude.com/claude-code. For Codex CLI, follow the install steps on https://github.com/openai/codex.

Then sign in once. In the Terminal app type `claude` (or `codex`), press Return and follow the steps on the screen: the program asks you to sign in with the account that has your subscription. When the sign-in is done, you can close the Terminal window. The app does not need it open.

If you have both programs, the app uses Claude. You can switch in the app's menu.

## Install: ask your Claude to do it

There are two ways to install the app. Choose one. This one is easier: Claude does everything. The next section is for people who want to run the commands themselves.

1. Open the Terminal app: press Command + Space, type "Terminal", press Return.
2. Type `claude` (or `codex`) and press Return.
3. Paste this message and press Return:

```
Install Proofread Hotkey on my Mac: clone https://github.com/zamesin/proofread-hotkey and follow the AGENTS.md file in it.
```

Claude downloads the files into the folder `proofread-hotkey` in your home folder, installs the app, starts it, checks that it works and tells you what to do next. This takes about a minute. Claude may ask for your permission to run commands: allow them. When Claude says that it is done, you can close the Terminal window.

## Install: do it yourself

Open the Terminal app (press Command + Space, type "Terminal", press Return). Paste these three lines one by one, and press Return after each line:

```
git clone https://github.com/zamesin/proofread-hotkey.git ~/proofread-hotkey
cd ~/proofread-hotkey
./install.sh
```

If macOS offers to install the "command line developer tools" after the first line, agree, wait until the install ends, and paste the first line again.

The third line puts **Proofread Hotkey** into your Applications folder and starts it. After that you can close the Terminal window.

## Check that it works

After the install you see a new icon in the menu bar at the top of the screen: lines of text with a check mark. Right after the first start macOS also shows a window about the Accessibility permission. Deal with it first: the next section tells what to do. Then copy any English text, press Command + Shift + ; and look at the top-right corner of the screen. The window with the corrected text appears there.

## Let the app take the selected text and paste the fix

With the Accessibility permission you select a text in any field and press the shortcut, and the corrected text replaces the selected text. Without it you copy the text, press the shortcut and paste the corrected text yourself.

On its first start the app asks macOS for this permission, and macOS shows a window about it:

1. In that window click **Open System Settings**.
2. System Settings opens at Privacy & Security → Accessibility. Turn on the switch next to Proofread Hotkey. macOS may ask for your password or Touch ID.

If you clicked **Deny**, closed the window, or want to give the permission later:

1. Click the app's icon in the menu bar.
2. Choose **Take the selected text and paste the fix: allow…**
3. macOS opens System Settings → Privacy & Security → Accessibility. Turn on the switch next to Proofread Hotkey.

When the permission is on, this menu item disappears. Now you select a text and press the shortcut. If the app still checks the text you copied earlier instead of the selected one, choose **Quit** in its menu and open Proofread Hotkey from the Applications folder again. Sometimes macOS needs this restart to apply the permission.

The app needs this permission for three things: to read the selected text in the active field, to press Command + C and Command + V in the active window (in browsers it takes and pastes the text this way), and to put the corrected text in place of the selection. It never moves the mouse pointer. Without the permission everything else works the same.

## The menu

Click the icon in the menu bar to see the menu:

- **Proofread** — the same as the shortcut.
- **Show the last changes** — opens the last window again, if 5 seconds were not enough.
- **Hotkey: ⇧⌘;. Change…** (⇧ is the Shift key, ⌘ is the Command key) — a small window appears. Press the new shortcut in it: two keys such as Command + Shift or Control + Option, plus one more key. The new shortcut replaces Command + Shift + ;.
- **Checks with** — choose Claude or Codex.
- **Edit the prompt…** — opens the text of the rules that the app gives to Claude or Codex. See the next section.
- **Start at login** — the app starts by itself when you turn on the Mac. It is on after the install.
- **Quit**.

## Change the rules of proofreading

The app gives Claude or Codex a text with rules: fix grammar, spelling and unnatural phrases; keep the meaning, the tone and the line breaks; translate words from another language that are mixed into an English text; explain every edit in plain English.

To change the rules, choose **Edit the prompt…** in the app's menu. A file with the rules opens in TextEdit. Edit it and save. The next check uses the new text. For example, you can ask for British English, or for explanations in your own language.

The last paragraphs of the file tell Claude to answer in two parts with the line `===CHANGES===` between them: the corrected text above the line, the list of changes below it. Do not change these paragraphs. Without them the app cannot show the list "What changed".

To go back to the built-in rules, delete the file: in Finder choose Go → Go to Folder…, paste `~/Library/Application Support/Proofread Hotkey`, press Return and move `prompt.txt` to the Trash.

## What happens to your text

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

After an update macOS may forget the Accessibility permission. The switch next to Proofread Hotkey may still look on, but it belongs to the old copy of the app. You notice this when you select a new text, press the shortcut, and the app checks the text you copied earlier, or the window says "Fixed and copied" and the selected text is not replaced. To fix it:

1. Open System Settings → Privacy & Security → Accessibility, select the Proofread Hotkey line and remove it with the minus button.
2. Click the app's icon in the menu bar and choose **Take the selected text and paste the fix: allow…**
3. Turn on the switch next to Proofread Hotkey.
4. Choose **Quit** in the app's menu and open Proofread Hotkey from the Applications folder again.

To uninstall: click the app's icon in the menu bar and choose **Start at login** so that the check mark next to it disappears. Then choose **Quit** in the same menu and move Proofread Hotkey from the Applications folder to the Trash. Three things stay on the disk, and you can delete them too: the folder `proofread-hotkey` in your home folder, the log file `~/Library/Logs/ProofreadHotkey.log` and, if you changed the rules, the file `prompt.txt` in the folder `~/Library/Application Support/Proofread Hotkey` (the section "Change the rules of proofreading" tells how to open this folder).

## If something does not work

- **The install ended with an error, or the icon did not appear.** Open the Terminal app, type `claude`, press Return and paste: "The install of Proofread Hotkey from ~/proofread-hotkey failed. Find out why and fix it." If this does not help, describe what you saw at https://github.com/zamesin/proofread-hotkey/issues
- **Nothing happens when I press the shortcut.** Check that the icon is in the menu bar. If it is not, open Proofread Hotkey from the Applications folder. If the icon is there, another app may use the same shortcut: choose another one in the menu.
- **The window says "The `claude` command was not found…" (or the same about `codex`).** Install Claude Code or Codex CLI and sign in, as the section "What you need" says. Then press the shortcut again.
- **The window says "Claude could not check the text." (or the same about Codex).** Open the Terminal app, type `claude` (or `codex`) and press Return. You will see whether you are signed in and whether your subscription is active.
- **The app checked an old text.** If you copy the text yourself: you pressed the shortcut without copying the new text. Copy first. If you gave the app the Accessibility permission: choose **Quit** in the menu and open the app again. If that does not help, macOS forgot the permission: do the four steps from "Update and uninstall".
- **The window says "Fixed and copied" instead of "Fixed and pasted".** Paste the corrected text yourself (Command + V). The app does not paste when you changed the selection, typed over it or switched apps during the check, and in code editors when nothing was selected (see "What happens when you press the shortcut"). If it never pastes anywhere, the app has no Accessibility permission, or macOS forgot it: do the four steps from "Update and uninstall".
- **The window says "The text is too long…".** The app takes texts up to 6000 characters. Check a longer text in parts.

## License

Free to use, copy and change. The license is MIT, see [LICENSE](LICENSE).
