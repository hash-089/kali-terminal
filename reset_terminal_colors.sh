#!/bin/bash
PROFILE=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep -E "^:[0-9a-f-]+$" | head -1)
dconf reset "/org/gnome/terminal/legacy/profiles:/:$PROFILE/foreground-color"
dconf reset "/org/gnome/terminal/legacy/profiles:/:$PROFILE/bold-color"
dconf reset "/org/gnome/terminal/legacy/profiles:/:$PROFILE/background-color"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE/use-theme-colors" "true"
echo "✅ Terminal colors reset to default"