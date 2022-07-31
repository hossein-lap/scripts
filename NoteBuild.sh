#  _  _ ___    
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              

#!/bin/sh
set -e


## using pandoc to compile {{{
#output="$(echo "${filename}" | sed s/md/pdf/g | sed s/src/pdf/g)"
#target="$(dirname "${filename}")/../pdf"
#mstemplate="$HOME/documents/notes/template.ms"
## }}}

filename="$1"
texrc="$(echo "${filename}" | sed s/md/pdf/g | sed s/src/pdf/g)"
output="$(echo "${filename}" | sed s/md/tex/g | sed s/src/tex/g)"

target="$(dirname "${filename}")/../pdf"
mkdir -p "$target"

mdown -sTlatex "${filename}" -o "${texrc}"


#groff -wall -ms -Tpdf $filename > $output
## using pandoc to compile {{{
#pandoc_latex () {
#pandoc \
#    --pdf-engine=xelatex \
#    -V 'geometry:margin=1in' \
#    -V 'monofont:Source Code Pro' \
#    $filename -o $output &
#}
#
#pandoc_groff_custom () {
#pandoc \
#    $filename \
#    -t ms --template=$HOME/documents/notes/template.ms -o $output &
#}
#
#pandoc_groff () {
#pandoc \
#    $filename -t ms -o $output &
#}
#
#pandoc_groff_custom
## }}}
