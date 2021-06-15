#!/bin/bash

#Cierro dmenu
pgrep -x dmenu && exit
#Guardo los discos a listar ($1) junto a sus tamaños ($4)
montable=$(lsblk -lp | grep "part /." | grep -v "sda" | awk '{print $1, "(" $4 ")"}')
#Si montable vacío: salgo
[[ "$montable" = "" ]] && exit 1
#Muestro elección y cribo tamaño ($2) para pasarlo directamente a udiskie
eleccion=$(echo "$montable" | dmenu -i -p "¿Disco a desmontar?" -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorPrincipal -nf '#'$colorPrincipal -fn 'Envy Code R-12' | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1

udiskie-umount "$eleccion"
