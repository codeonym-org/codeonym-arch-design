# Drawing tablet on GNOME Wayland

GNOME drives tablets through `libwacom` + libinput — no `xf86-input-wacom` needed (that driver is X11-only).

## Setup
1. Plug in the tablet, run `bash scripts/check.sh` — it lists detected tablets.
2. *Settings → Wacom Tablet* (only visible while a tablet is connected):
   - **Map to monitor**: pick the monitor you draw on; enable *Keep aspect ratio* so circles stay circles.
   - **Stylus → Tip pressure feel**: slide toward *Soft* if you press lightly.
   - **Buttons**: map the lower pen button to *Right click* (Krita's pop-up palette) and the upper to *Middle click* (pan).
3. In Krita: *Settings → Configure Krita → Tablet Settings → Input pressure global curve* — make an S-curve if strokes jump from thin to thick.

## Non-Wacom tablets (Huion, XP-Pen)
Most work through the same GNOME panel if their model is in libwacom. If the panel doesn't appear:
```bash
libwacom-list-local-devices     # is it recognized?
```
If not listed, it still works as a generic pen device; configure pressure in Krita only. OpenTabletDriver (`yay -S opentabletdriver`) adds full configuration for unsupported models.

## Test
Krita → brush *Basic-5 Size Opacity* → draw a stroke pressing light → hard → light. It should taper smoothly at both ends.
