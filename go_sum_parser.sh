#!/usr/bin/env bash

if [[ ${#} -ne 1 ]]; then
	echo "Exactly one argument required"

	exit 1
fi

if [[ ! -f /usr/bin/xclip ]]; then
	echo "Please install xclip to copy output"
	echo "to clipboard"

	exit 1
fi

rm -f /tmp/go.sum || true

wget -c ${1} -P /tmp > /dev/null 2>&1

if [[ ! -f /tmp/go.sum ]]; then
	echo "It seems you have downloaded wrong file!"
	echo "Please check your URL!"

	exit 1
fi

cat /tmp/go.sum \
	| cut -d " " -f 1,2 | \
	xargs -i echo \"{}\" |
	xclip  -sel clip
	
echo "lines found: " $(cat /tmp/go.sum | wc -l)
