#!/usr/bin/python
"""Tech HUD Power Menu — GTK3 + Layer Shell"""

import gi
import subprocess
import os
import signal

gi.require_version("Gtk", "3.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import Gtk, Gdk, GtkLayerShell, GLib

CSS_FILE = os.path.expanduser("~/.config/waybar/scripts/power-ui.css")
PID_FILE = "/tmp/power-ui.pid"

ACTIONS = [
    {"icon": "⏻", "label": "Shutdown", "cmd": ["systemctl", "poweroff"], "class": "shutdown"},
    {"icon": "⟳", "label": "Reboot", "cmd": ["systemctl", "reboot"], "class": "reboot"},
    {"icon": "⏾", "label": "Suspend", "cmd": ["systemctl", "suspend"], "class": "suspend"},
    {"icon": "⇥", "label": "Logout", "cmd": ["hyprctl", "dispatch", "exit"], "class": "logout"},
]


class PowerMenu(Gtk.Window):
    def __init__(self):
        super().__init__()

        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.TOP, 10)
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.RIGHT, 10)
        GtkLayerShell.set_exclusive_zone(self, 0)
        GtkLayerShell.set_keyboard_mode(
            self, GtkLayerShell.KeyboardMode.ON_DEMAND
        )

        self.get_style_context().add_class("power-window")
        self._load_css()
        self._build_ui()
        self.connect("key-press-event", self._on_key)

    def _load_css(self):
        css_provider = Gtk.CssProvider()
        try:
            css_provider.load_from_path(CSS_FILE)
        except GLib.Error:
            pass
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
        )

    def _build_ui(self):
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        main_box.get_style_context().add_class("main-box")
        self.add(main_box)

        # Header
        title = Gtk.Label(label="SYSTEM")
        title.get_style_context().add_class("header-title")
        title.set_halign(Gtk.Align.START)
        main_box.pack_start(title, False, False, 0)

        # Buttons
        for action in ACTIONS:
            btn = Gtk.Button()
            btn.get_style_context().add_class("power-btn")
            btn.get_style_context().add_class(action["class"])
            btn.set_relief(Gtk.ReliefStyle.NONE)

            box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)

            icon = Gtk.Label(label=action["icon"])
            icon.get_style_context().add_class("power-icon")
            box.pack_start(icon, False, False, 0)

            label = Gtk.Label(label=action["label"])
            label.get_style_context().add_class("power-label")
            label.set_halign(Gtk.Align.START)
            box.pack_start(label, True, True, 0)

            btn.add(box)
            btn.connect("clicked", lambda b, cmd=action["cmd"]: self._exec(cmd))
            main_box.pack_start(btn, False, False, 0)

    def _exec(self, cmd):
        self._quit()
        subprocess.Popen(cmd)

    def _on_key(self, widget, event):
        if event.keyval == Gdk.KEY_Escape:
            self._quit()
            return True
        return False

    def _quit(self):
        try:
            os.remove(PID_FILE)
        except FileNotFoundError:
            pass
        self.destroy()
        Gtk.main_quit()


def main():
    if os.path.exists(PID_FILE):
        try:
            old_pid = int(open(PID_FILE).read().strip())
            os.kill(old_pid, signal.SIGTERM)
            os.remove(PID_FILE)
            return
        except (ProcessLookupError, ValueError):
            try:
                os.remove(PID_FILE)
            except FileNotFoundError:
                pass

    with open(PID_FILE, "w") as f:
        f.write(str(os.getpid()))

    def on_sigterm(*args):
        try:
            os.remove(PID_FILE)
        except FileNotFoundError:
            pass
        Gtk.main_quit()

    signal.signal(signal.SIGTERM, on_sigterm)

    win = PowerMenu()
    win.show_all()
    Gtk.main()


if __name__ == "__main__":
    main()
