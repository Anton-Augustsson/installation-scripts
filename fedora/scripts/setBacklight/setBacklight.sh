#!/bin/bash

device='tpacpi::kbd_backlight'
default_brightness=0
current_brightness=$(sudo brightnessctl --device="$device" | grep "Current brightness" | awk '{print $3}')

setBacklight() {
	sudo brightnessctl --device="$device" set $1
}

if [ $current_brightness == $default_brightness ]
then
	setBacklight 1
else
	setBacklight 0
fi
