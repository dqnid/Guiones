#!/bin/bash
fusermount -u ~/Android/
pgrep -x dmenu && exit
montable=$(simple-mtpfs -l)
[[ "$montable" = "" ]] && exit 1
eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Dispositivo a montar?' -theme ~/Guiones/Temas/discos.rasi <<< "$montable" | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1
error=$(simple-mtpfs --device "$eleccion" ~/Android/)
#No funciona si error cuando conectado pero error.
#simple-mtpfs no retorna nada si error, tampoco si no. 
[[ ! -z "$error" ]] && notify-send "Error en montaje" $error || notify-send "Dispositivo montado" "en: ~/Android/"
