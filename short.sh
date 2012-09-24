#!/bin/sh

# returns a `tilidied' version of the PWD if your PWD gets more than 3
# directories deep (relative to either `/' or `~')

pwd | sed "s#$HOME#~#" | awk -F"/" '{ if (NF>3) print $1 "/.../" $(NF-1) "/" $(NF); else print $0 }'

exit 0
