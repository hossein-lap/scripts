# scripts

Shell scripts

**Optional:**

- Create `$HOME/.local/bin` directory and add it to the `PATH` variable.
Then put these scripts on the `~/.local/bin` dir.

### dm-shot.sh

Take screenshot using `scrot` and `dmenu`.

- Dependencies
	- scrot
	- dmenu
	- sxiv
	- xclip
	- fortune

### dm-ps.sh

Search and kill processes.

- Dependencies
	- dmenu
	- fortune
	- awk
	- sed

### dm-srun.sh

Run custom make scripts from `~/.local/bin` and
`~/.local/dev/hossein-lap/scripts/` which they are not part of `$PATH`
variable.

- Dependencies
	- dmenu

### dm-usb.sh

Manage usb devices.

1. Mount
1. Unmount
1. Eject

- Dependencies
	- lsblk
	- grep
	- udisks2

### dm-fscreen.sh

Record from screen using `ffmpeg
with more options to record area, whole screen or active window.

- Dependencies
	- ffmpeg
	- xdpyinfo
	- awk

### ff-screenrec.sh

Record from screen using `ffmpeg`.

- Dependencies
	- ffmpeg
	- xdpyinfo
	- awk
	- pgrep
	- kill
	- fortune

### im-color.sh

Change specific color in photo.

- Dependencies
	- imagemagick

### im-negate.sh

Negate photo's color

- Dependencies
	- imagemagick

### im-shadow.sh

Add shadow border to photos.

- Dependencies
	- imagemagick

### lfub

Just a simple `lf` file-manager runner.

- Dependencies
	- ueberzug
	- bat
	- perl-file-mimeinfo` (`mimetype`)

### wcam.sh

Show webcam with no sound from `/dev/video0`.

- Dependencies
	- mplayer

### tb.sh

Send command output to a pastebin service ([termbin.com](termbin.com)).

- Dependencies
	- netcat

### note-take.sh

A daily note-taking script with `markdown` and using `vim` text editor.

- Dependencies
	- vim

### note-build.sh

Build `pdf` and `html` files from daily notes.

**Neededd to be used inside vim**.

- Dependencies
	- pandoc
	- Rmarkdown
	- LaTeX
	- groff

### xrate.sh

Set second keyboard layout and Keypress dely

- Dependencies
	- xrate
