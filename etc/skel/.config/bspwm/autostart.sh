#!/bin/bash
# =============================================================================
# autostart.sh — bspwm session startup script
#
# Called BY bspwmrc (not by the display manager directly), so it has NO
# window-manager loop — it just starts the background services and exits.
# bspwm's status bar is polybar (shipped by the kiro-polybar package).
#
# To autostart your own apps, add:  run "your-app"
# To stop an autostart entry, comment it out with #
# =============================================================================

# run() — start a program only if it is not already running. A bspwm restart
# (super+alt+r) re-sources bspwmrc and re-runs this script, so the exact-match
# pgrep guard stops tray applets from stacking up duplicates on reload.
run() {
  if ! pgrep -x "$(basename "$1" | head -c 15)" >/dev/null; then
    "$@" &
  fi
}

# ── One-time setup ────────────────────────────────────────────────────────────
xsetroot -cursor_name left_ptr &                     # default X cursor shape

# ── Monitor layout ────────────────────────────────────────────────────────────
# Apply a saved arandr/xrandr screen layout named after the current user.
# Generate your layout with arandr, save it to ~/.screenlayout/<username>.sh
# Uncomment the xrandr line below if you are running inside VirtualBox.
#run xrandr --output Virtual-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
# screen layout generated with arandr
[ -f "$HOME/.screenlayout/$(whoami).sh" ] && sh "$HOME/.screenlayout/$(whoami).sh"

# ── System tray applets ───────────────────────────────────────────────────────
run variety                                          # Wallpaper rotator
run nm-applet                                        # NetworkManager wifi/eth tray
run pamac-tray                                       # Arch package manager tray
run xfce4-power-manager                              # Battery / display power management
run blueberry-tray                                   # Bluetooth manager tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1  # Polkit auth popups (sudo GUI)
run /usr/lib/xfce4/notifyd/xfce4-notifyd             # Desktop notification daemon

# ── Compositor ────────────────────────────────────────────────────────────────
# Provides transparency, shadows and smooth window rendering.
# fastcompmgr is the lightweight default; toggle with super+g. One at a time.
run fastcompmgr -c

# ── Keyboard ──────────────────────────────────────────────────────────────────
run numlockx on                                      # Enable numlock on login
# sxhkd handles keybindings. QWERTY is the default; a Belgian (be) keyboard
# layout — chosen at install — auto-loads the AZERTY variant. The two files
# differ only in the workspace number-row bindings. No manual editing needed.
layout=$(setxkbmap -query | awk '/^layout:/ {print $2}')
case ",$layout," in
  *,be,*) sxhkd_cfg=sxhkdrc-azerty ;;
  *)      sxhkd_cfg=sxhkdrc-qwerty ;;
esac
run sxhkd -c ~/.config/bspwm/sxhkd/"$sxhkd_cfg"

# ── Volume control ────────────────────────────────────────────────────────────
#run volumeicon                                       # PipeWire/PulseAudio volume tray (disabled)

# ── Wallpaper ─────────────────────────────────────────────────────────────────
# Restore the last wallpaper set by feh (saved to ~/.fehbg automatically).
# Falls back to the default Kiro wallpaper if no history exists yet.
if [ -f "$HOME/.fehbg" ]; then
    sh "$HOME/.fehbg" &
else
    feh --bg-fill /usr/share/backgrounds/kiro/kiro-wallpaper.jpg &
fi

# ── Status bar ────────────────────────────────────────────────────────────────
# polybar (shipped by the kiro-polybar package, not this repo).
$HOME/.config/polybar/launch.sh &
