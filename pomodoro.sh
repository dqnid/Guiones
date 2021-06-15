#!/bin/bash
if test $# -eq 1; then
	if test $1 == "--help"; then
		echo "pomodoro.sh [tiempo] [s|m|h|d]"
		exit 2
	fi
fi
#Añadir selector de sonido 
#Añadir dmenu
eleccion=$(echo "" | dmenu -i -p "¿Tiempo?" -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorPrincipal -nf '#'$colorPrincipal -fn 'Envy Code R-12')
[[ "$eleccion" = "" ]] && exit 3
sleep $eleccion
#espeak -v es "Tiempo"
mpg123 --loop 1 ~/.config/Alarmas/pomodoro.mp3 
