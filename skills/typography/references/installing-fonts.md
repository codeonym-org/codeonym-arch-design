# Installing fonts on Arch

## Order of preference
1. **Official repo package** — updates automatically: `pacman -Ss ttf- otf-` then `sudo pacman -S <pkg>`.
2. **AUR package**: `yay -Ss <name> font`.
3. **Font Manager → Google Fonts** tab: browse, preview and click *Install* — goes to `~/.local/share/fonts` for your user only.
4. **Manual**: copy `.ttf`/`.otf` into `~/.local/share/fonts/<Family>/`, then `fc-cache -f`.

Verify:
```bash
fc-list | grep -i "<family>"
bash scripts/font-inventory.sh "<family>"
```

## Removing
Repo fonts: `sudo pacman -Rns <pkg>`. User fonts: delete the folder from `~/.local/share/fonts`, then `fc-cache -f`. Apps like Inkscape, GIMP, Krita and Scribus must be restarted to see changes.

## Font Manager tips
- Collections (left panel): make one per project, e.g. `codeonym-brand`, so you can find its fonts quickly.
- *Disable* rarely used font families instead of uninstalling to keep app font menus short.
- Compare mode (the two-pane icon) previews the same text in several fonts.

## Licensing quick guide
| License | Web embed | Desktop use | Modify |
|---|---|---|---|
| SIL OFL (Inter, IBM Plex, Source, Fira, JetBrains Mono, Noto) | ✔ | ✔ | ✔ (rename if distributing) |
| Apache 2.0 (Roboto, Open Sans) | ✔ | ✔ | ✔ |
| Commercial / "free for personal use" | Check EULA — often ✘ | often personal only | ✘ |

## Web use
- Next.js: `next/font/local` pointing at WOFF2 files from `scripts/webfont.sh`, or `next/font/google` for Google-hosted families.
- Plain sites: `bash scripts/webfont.sh MyFont-*.ttf public/fonts` → include `public/fonts/fonts.css`.
- Variable fonts (like `InterVariable.ttf`) cover all weights in one file — prefer them for the web.
