#!/bin/bash
#   ____     _
#  |  _ \   | |
#  | |_) |  | |
#  |  __/ |_| |
#  |_|   \___/
#
set -e

# using R {{{
r_build () {
	a=$( dirname "$1" )
	i=$( echo "$a" | sed 's/\<md\>/pdf/g' )
	j=$( echo "$a" | sed 's/\<md\>/html/g' )

	Rscript -e "rmarkdown::render(input = '$1', output_dir = '$i', output_format = 'pdf_document')" 2>&1 > /dev/null
	Rscript -e "rmarkdown::render(input = '$1', output_dir = '$j', output_format = 'html_document')" 2>&1 > /dev/null
}
# }}}
## Using pandoc {{{
#pandoc_build () {
	#i=$( echo "$1" | sed 's/\<md\>/pdf/g' )
	#j=$( echo "$1" | sed 's/\<md\>/html/g' )
#
	#pandoc -V geometry:margin=1in "$1" -o "$i"
	##pandoc -t ms "$1" -o "$i"
	#pandoc -t html "$1" -o "$j"
#}
## }}}

## using pandoc
#pandoc_build "$1"

## usging R
r_build "$1"
