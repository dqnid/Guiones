#!/bin/bash
fusermount -u ~/Android/
pgrep -x dmenu && exit
montable=$(simple-mtpfs -l)
[[ "$montable" = "" ]] && exit 1
eleccion=$(echo "$montable" | dmenu -i -p "¿Dispositivo a montar?" -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorPrincipal -nf '#'$colorPrincipal -fn 'Envy Code R-12' | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1
error=$(simple-mtpfs --device "$eleccion" ~/Android/)
#No funciona si error cuando conectado pero error.
#simple-mtpfs no retorna nada si error, tampoco si no. 
[[ ! -z "$error" ]] && notify-send "Error en montaje" $error || notify-send "Dispositivo montado" "en: ~/Android/"
