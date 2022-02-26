#!/bin/bash

#Cierro dmenu
pgrep -x rofi && exit
#Guardo los discos a listar ($1) junto a sus tamaños ($4)
#Probar a jugar con lsblk -lpf para mostrar la etiqueta
montable=$(lsblk -lp | grep "part $" | grep -v "sda" | awk '{print $1, "(" $4 ")"}')
#Si montable vacío: salgo
[[ "$montable" = "" ]] && exit 1
eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Disco a montar?' -theme ~/Guiones/Temas/discos.rasi <<< "$montable" | awk '{print($1)}')
#eleccion=$(echo "$montable" | dmenu -i -p "¿Disco a montar?" -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorAzul -nf '#'$colorAzul -fn 'Envy Code R-12' | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1

udisksctl mount -b "$eleccion"
notify-send -i ~/.iconos/discoIN.jpg $eleccion "Montado correctamente"
