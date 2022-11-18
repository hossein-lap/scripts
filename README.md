# scripts

Shell scripts

**Optional:**

- Create `$HOME/.local/bin` directory and add it to the `PATH` variable.
Then put these scripts on the `~/.local/bin` dir.

## dmenu scripts

### dm-shot.sh

Take screenshot using `scrot` and `dmenu`.

- Dependencies
	- scrot
	- dmenu
	- (n)sxiv
	- xclip
	- dunst (or any notification manager)

### dm-kill.sh

Search and kill processes.

- Dependencies
	- dmenu
	- awk
	- sed
	- dunst (or any notification manager)

### dm-srun.sh

Run custom make scripts from `~/.local/bin` and
`~/.local/dev/hossein-lap/scripts/` which they are not
part of my `$PATH` variable.

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
	- dunst (or any notification manager)

### dm-record.sh

Record from screen using `ffmpeg`
with more options to record area, whole screen or active window.

- Dependencies
	- ffmpeg
	- xdpyinfo
	- awk
	- pulseaudio

### dm-exit.sh

To reboot, poweroff and lock the screen.
To this script works, you need to add a rule
to `sudoers` file for `/bin/reboot` and `/bin/shutdown`
to sudo not asking for a password.

- Dependencies
    - sudo
    - slock
    - sudo rule to run `shutdown` and `reboot` commands without asking for a password

## imageMagick scripts

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

## Other sctipts

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

### theping.sh

Show the ping of 1.1.1.1 in `slstatus` program

- Dependencies
	- ping

### cmus-tmux.sh

Run `cmus` inside `tmux` as mpd alternative.

- Dependencies
    - st
    - cmus
    - tmux

### r.sh

Run programs inside terminal and separate them from shell

- Dependencies
    - nohub
