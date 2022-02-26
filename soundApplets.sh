#!/bin/sh
SERVICE1="pa-applet"
SERVICE2="blueman-applet"
if pgrep -x "$SERVICE1" >/dev/null
then
	killall "$SERVICE1"
else
	~/Paquetes/pa-applet/src/pa-applet &
fi

if pgrep -x "$SERVICE2" >/dev/null
then
	killall "$SERVICE2"
else
	$SERVICE2 &
fi
