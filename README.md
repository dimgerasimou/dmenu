# dmenu - dynamic menu

dmenu is an efficient dynamic menu for X by suckless.  
This is my heavily patched version that can be used for app launcher, prompt and in scripts.

## Requirements

In order to build dmenu you need the Xlib header files.

## Installation

Edit config.mk to match your local setup (dmenu is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dmenu

```bash
sudo make clean install
```

## Patches

- allow-color-font
- alpha
- border
- topbar
- center
- lineheight
- numbers
- password
- highlight
- xresources
- instant
- tsv

## Running dmenu

See the man page for details.