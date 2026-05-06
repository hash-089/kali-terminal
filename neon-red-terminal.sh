#!/bin/bash

# Neon Red Terminal Color Configurator for Kali Linux
# Sets GNOME Terminal text color to neon red

# Neon red color codes
NEON_RED_HEX="#FF073A"
NEON_RED_RGB="rgb(255,7,58)"

# Function to get default profile ID
get_profile_id() {
    local profile_id=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep -E '^:[0-9a-f-]+$' | head -1)
    
    if [[ -z "$profile_id" ]]; then
        # Try alternative method
        profile_id=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    fi
    
    echo "$profile_id"
}

# Check if dconf is installed
if ! command -v dconf &> /dev/null; then
    echo "Installing dconf-cli..."
    sudo apt update
    sudo apt install -y dconf-cli
fi

# Get profile ID
PROFILE_ID=$(get_profile_id)

if [[ -z "$PROFILE_ID" ]]; then
    echo "Error: Could not find terminal profile ID"
    echo "Please open terminal preferences manually and configure colors"
    exit 1
fi

echo "Found profile ID: $PROFILE_ID"
echo "Configuring neon red terminal..."

# Set neon red as foreground (text) color
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/foreground-color" "'$NEON_RED_HEX'"

# Set bold color to the same neon red
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/bold-color" "'$NEON_RED_HEX'"

# Disable "show bold text in bright colors" for consistent neon red
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/bold-color-same-as-fg" "true"

# Optional: Set dark background for better contrast
BG_COLOR="#0A0A0A"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/background-color" "'$BG_COLOR'"

# Optional: Set cursor color to neon red
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/cursor-colors-set" "true"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/cursor-background-color" "'$NEON_RED_HEX'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/cursor-foreground-color" "'$BG_COLOR'"

# Use theme colors? Disable to use custom
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/use-theme-colors" "false"

echo "✅ Terminal colors configured to neon red: $NEON_RED_HEX"
echo "Background set to dark: $BG_COLOR"
echo ""
echo "Changes applied immediately! Open a new terminal to see effect."
echo ""
echo "To reset to default:"
echo "  dconf reset /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/foreground-color" 
