#!/bin/sh

timestamp="$(date '+%Y%m%d_%H%M')"
prompt="$(echo ${0} | awk -F '/' '{print $NF;}')"
list="${*}"

echo "${prompt}: [${*}]: merging... "
magick montage ${@} -mode concatenate -tile 1x1 merged-${timestamp}.pdf
