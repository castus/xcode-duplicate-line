Duplicate Line
=========

Xcode plugin to duplicate selected line or lines.

# How to use it

Select line(s) you want to duplicate, then press `^⇧D`. Bum, line(s) duplicated!

![Duplicate line plugin presentation](https://raw.github.com/castus/xcode-duplicate-line/master/screenshot/presentation.gif)

# Change the shortcut

You can do it only by overriding current shortcut in Keyboard settings. To do it, follow these steps:

1. Go to System Preferences
2. Keyboard
3. Shortcuts
4. App Shortcuts
5. +
6. Application: Xcode
7. Menu Title: Duplicate Line
8. Keyboard Shortcut:
9. Add

Thanks to [@nicoschuele](https://github.com/nicoschuele) for that tip ;)

# Installation

## Alcatraz
1. Install using [Alcatraz](http://mneorr.github.io/Alcatraz/). Search for "Duplicate Line" plugin
2. Restart Xcode

## Manually

1. Clone the repo.
2. Build it. Plugin will automatically be installed in ``~/Library/Application Support/Developer/Shared/Xcode/Plug-ins`.
3. Restart Xcode

# Uninstall

Delete the following directory

```
$HOME/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/DuplicateLine.xcplugin
```

# Xcode 8 version
Available here https://github.com/castus/Xcode8Extensions


# License
MIT License
