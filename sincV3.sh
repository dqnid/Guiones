#!/bin/bash
opcion="Universidad|Música|voidrice"
usb=""
docs="Documentos"

if test $# -ne 1; then
	exit 1
fi
opcionUsb=$(lsblk -lp | grep "part /." | grep -v "sda" | awk '{print $7}')
if test $1 -eq 1; then
	frase="Origen"
else
	frase="Destino"
fi

usb=$(rofi -no-config -no-lazy-grab -dmenu -i -p $frase -theme ~/Guiones/Temas/sinc.rasi <<< "$opcionUsb")
[[ "$usb" = "" ]] && exit 1
eleccion=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '¿Directorio?' -theme ~/Guiones/Temas/sinc.rasi <<< "$opcion")
case "$eleccion" in
	    Universidad)
			if test $1 -eq 1; then
	    		rsync -vr $usb/Documentos/Universidad/ $docs/Universidad/ -auto
	    		rsync -vr $usb/Vídeos/Lecciones/ ~/Vídeos/Lecciones/ -auto
            	rsync -vr $usb/Documentos/Anotaciones/ $docs/Anotaciones/ -auto
			else 
	         	rsync -vr $docs/Universidad/ $usb/Documentos/Universidad/ -auto
        		rsync -vr ~/Vídeos/Lecciones/ $usb/Vídeos/Lecciones/ -auto
    			rsync -vr $docs/Anotaciones/ $usb/Documentos/Anotaciones/ -auto
			fi
	    ;;
		Música)
			if test $1 -eq 1; then
	        	rsync -vr $usb/Música/ ~/Música/ -auto
			else 
	        	rsync -vr ~/Música/ $usb/Música/ -auto
			fi
		;;
        voidrice)  #Mejor hacer un bucle con un array de los ficheros y carpetas
            rsync -vr /etc/X11/xorg.conf.d/00-keyboard.conf /run/media/danih/$usb/Documentos/voidrice_Arch/etc/X11/xorg.conf.d/
            rsync -vr /etc/X11/xorg.conf.d/50-synaptics.conf /run/media/danih/$usb/Documentos/voidrice_Arch/etc/X11/xorg.conf.d/
            rsync -vr ~/.bashrc $usb/Documentos/voidrice_Arch/
            rsync -vr ~/.xinitrc $usb/Documentos/voidrice_Arch/
            rsync -vr ~/Paquetes/st/ $usb/Documentos/voidrice_Arch/Paquetes/st/
            rsync -vr ~/.config/i3/ $usb/Documentos/voidrice_Arch/config/i3/
            rsync -vr ~/.config/polybar/ $usb/Documentos/voidrice_Arch/config/polybar/
            rsync -vr ~/.config/mpd/ $usb/Documentos/voidrice_Arch/config/mpd/
            rsync -vr ~/.config/ncmpcpp/ $usb/Documentos/voidrice_Arch/config/ncmpcpp/
            rsync -vr ~/.config/dunst/ $usb/Documentos/voidrice_Arch/config/dunst/
            rsync -vr ~/.config/nvim/ $usb/Documentos/voidrice_Arch/config/nvim/
            rsync -vr ~/.config/picom.conf $usb/Documentos/voidrice_Arch/config/
            rsync -vr ~/.config/ranger/ $usb/Documentos/voidrice_Arch/config/ranger/ 
            rsync -vr ~/Guiones/ $usb/Documentos/voidrice_Arch/Guiones/
            rsync -vr ~/.config/sxhkd/ $usb/Documentos/voidrice_Arch/config/sxhkd/ 
    	;;
esac
notify-send -i ~/.iconos/file.png "Sincronización terminada"
read -p "Pulsa intro para salir"
