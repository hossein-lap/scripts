#!/bin/sh
#  _  _ ___
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#

set -e

note_take () {
	TheDate=$(date +%Y-%m-%d)

	if [ ! -d "${HOME}/Documents/notes/" ]; then
		mkdir -p ~/Documents/notes/
	fi
	if [ ! -d "${HOME}/Documents/notes/md" ]; then
		mkdir -p ~/Documents/notes/md/
	fi
	if [ ! -d "${HOME}/Documents/notes/pdf" ]; then
		mkdir -p ~/Documents/notes/pdf/
	fi
	if [ ! -d "${HOME}/Documents/notes/html" ]; then
		mkdir -p ~/Documents/notes/html/
	fi

	NoteFilename="${HOME}/Documents/notes/md/note_${TheDate}.md"

	if [ ! -f "${NoteFilename}" ]; then
		printf '%s\n' "# Note for ${TheDate}" > "${NoteFilename}"
	fi

	vim -c "norm Go" \
		-c "norm Go## $(date +%H:%M)" \
		-c "norm Go" \
		-c "norm Go" \
		-c "norm zz" "${NoteFilename}"
}

note_take "$1"
