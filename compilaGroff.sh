#!/bin/bash
groff -ms -D UTF-8 "$1".ms -T pdf > "$1".pdf
if test $# -eq 2; then
	if test $2 -eq 1; then
		mupdf "$1".pdf &
	fi
fi
exit 1
