#!/bin/bash
opcion="Universidad\nMúsica\nvoidrice"
opcion2="Completo\nProyectos\nAsignaturas"
usb="C432-773E"
docs="Documentos"
asignaturas="Segundo[[:space:]]Cuatrimestre"
proyectos="Proyectos"

if test $# -ne 1; then
	exit 1
fi
#Más sencillo con lsblk : mirar montaUSB.sh
if test $1 -eq 1; then
	for dir in /run/media/danih/*; do 
		opcionUsb+=$(echo $dir | awk -F'danih/' '{print $2}')"\n"	
	done
	usb=$(echo -e "$opcionUsb" | dmenu -i -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorPrincipal -nf '#'$colorPrincipal -fn 'Envy Code R-12')
fi	
[[ "$usb" = "" ]] && exit 1
eleccion=$(echo -e "$opcion" | dmenu -i -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorAzul -nf '#'$colorAzul -fn 'Envy Code R-12')
case "$eleccion" in
	    Universidad)
				eleccion2=$(echo -e "$opcion2" | dmenu -i -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorAzul -nf '#'$colorAzul -fn 'Envy Code R-12')
				case "$eleccion2" in
					Completo)
	           	 		rsync -vr /run/media/danih/$usb/Documentos/Universidad/ $docs/Universidad/ -auto
						;;		
					Proyectos)
	           	 		rsync -vr /run/media/danih/$usb/Documentos/Universidad/$proyectos $docs/Universidad/$proyectos/ -auto
						;;
					Asignaturas)
	           	 		rsync -vr /run/media/danih/$usb/Documentos/Universidad/$asignaturas/ -auto $docs/Universidad/$asignaturas/
						;;
				esac
                rsync -vr /run/media/danih/$usb/Documentos/Anotaciones/ $docs/Anotaciones/ -auto
                rsync -vr /run/media/danih/$usb/Documentos/Universidad/Horarios/ $docs/Universidad/Horarios/ -auto
	            ;;
	    Música)
                rsync -vr ~/Música/ /run/media/danih/$usb/Música/ -auto
                rsync -vr /run/media/danih/$usb/Música/ ~/Música/ -auto
                ;;
        voidrice)  #Mejor hacer un bucle con un array de los ficheros y carpetas
                rsync -vr /etc/X11/xorg.conf.d/00-keyboard.conf /run/media/danih/$usb/Documentos/voidrice_Arch/etc/X11/xorg.conf.d/
                rsync -vr /etc/X11/xorg.conf.d/50-synaptics.conf /run/media/danih/$usb/Documentos/voidrice_Arch/etc/X11/xorg.conf.d/
                rsync -vr ~/.bashrc /run/media/danih/$usb/Documentos/voidrice_Arch/
                rsync -vr ~/.xinitrc /run/media/danih/$usb/Documentos/voidrice_Arch/
                rsync -vr ~/Paquetes/st/ /run/media/danih/$usb/Documentos/voidrice_Arch/Paquetes/st/
                rsync -vr ~/.config/i3/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/i3/
                rsync -vr ~/.config/polybar/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/polybar/
                rsync -vr ~/.config/mpd/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/mpd/
                rsync -vr ~/.config/ncmpcpp/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/ncmpcpp/
                rsync -vr ~/.config/dunst/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/dunst/
                rsync -vr ~/.config/nvim/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/nvim/
                rsync -vr ~/.config/picom.conf /run/media/danih/$usb/Documentos/voidrice_Arch/config/
                rsync -vr ~/.config/ranger/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/ranger/ 
                rsync -vr ~/Scripts/ /run/media/danih/$usb/Documentos/voidrice_Arch/Scripts/
                rsync -vr ~/.config/sxhkd/ /run/media/danih/$usb/Documentos/voidrice_Arch/config/sxhkd/ 
                ;;
esac
read -p "Pulsa para salir"
