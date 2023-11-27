#!/bin/bash

i3status --config ~/.config/i3status/config | while :
do
	read line
	if kill -0 $(pgrep 'run-vk-vpn.sh'); then
		vkvpnstatus_str="UP"
		vkvpnstatus_color="#B8BB26"
	else
		vkvpnstatus_str="DOWN"
		vkvpnstatus_color="#CC241D"
	fi
	vkvpnstatus_format="{\"full_text\": \"vkvpn [ $vkvpnstatus_str ]\", \"separator\": true, \"separator_block_width\": 12, \"color\": \"$vkvpnstatus_color\"}"
	kblayout=`xkblayout-state print %s`
	kblayout_format="{\"full_text\": \"kb [ $kblayout ]\", \"separator\": true, \"separator_block_width\": 12}"
	echo "${line/[/[$kblayout_format,$vkvpnstatus_format,}" || exit 1
done

