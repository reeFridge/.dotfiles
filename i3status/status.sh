#!/bin/bash

i3status --config ~/.config/i3status/config | while :
do
	read line
	kblayout=`xkblayout-state print %s`
	kblayout_format="{\"full_text\": \"kb [ $kblayout ]\", \"separator\": true, \"separator_block_width\": 12}"
	echo "${line/[/[$kblayout_format,}" || exit 1
done

