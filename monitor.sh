#!/bin/bash
interno=LVDS1
externo=VGA1
externo2=HDMI1
eleccion=""

#Todo mal pero tremendo palo cambiarlo:
# usar dmenu
# ejecutar un solo randr con variables
# modificar las variables en función de la entrada
# igual resta sacar las opciones del propio xrandr usando awk y grep
if xrandr | grep "$externo connected" && xrandr | grep "$externo2 connected"; then	
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 3 -theme ~/Guiones/Temas/monitor.rasi <<< "Una|Dos|Tres")"
	case "$eleccion" in
	Dos)
        xrandr --output "$interno" --off --output "$externo2" --above "$interno" --auto --output "$externo" --auto --rotate left --right-of "$externo2"
	;;
	Tres) 
        xrandr --output "$interno" --auto --output "$externo2" --above "$interno" --auto --output "$externo" --auto --right-of "$externo2"
	;;
	Una) 
		xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
	;;
	esac
elif xrandr | grep "$externo connected"; then
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 4 -theme ~/Guiones/Temas/monitor.rasi <<< "Dual|Interna|Externa|Duplicar")"
	case "$eleccion" in
	Dual)
		xrandr --output "$interno" --auto --output "$externo" --auto --above "$interno" --output "$externo2" --off
	;;
	Duplicar) 
		xrandr --output "$interno" --auto --output "$externo" --same-as "$interno" --output "$externo2" --off
	;;
	Externa) 
		xrandr --output "$interno" --auto --output "$externo" --auto --above "$interno" --output "$externo2" --off
		xrandr --output "$externo" --auto --output "$interno" --off --output "$externo2" --off
	;;
	Interna) 
		xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
	;;
	esac
elif xrandr | grep "$externo2 connected"; then
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 4 -theme ~/Guiones/Temas/monitor.rasi <<< "Dual|Interna|Externa|Duplicar")"
	case "$eleccion" in
	Dual)
		xrandr --output "$interno" --auto --primary --output "$externo2" --above "$interno" --auto --output "$externo" --off
	;;
	Duplicar) 
		xrandr --output "$interno" --auto --output "$externo2" --same-as "$interno" --output "$externo" --off
	;;
	Externa) 
		xrandr --output "$interno" --auto --primary --output "$externo2" --above "$interno" --auto --output "$externo" --off
		xrandr --output "$externo2" --output "$interno" --off --output "$externo" --off
	;;
	Interna) 
	xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
	;;
	esac	
else 
	xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
fi
[[ "eleccion" = "" ]] && exit 1
i3 restart
bspc wm -r
