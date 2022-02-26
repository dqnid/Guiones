#!/bin/bash
groff -ms -D UTF-8 ~/Documentos/Anotaciones/Ficheros\ Fuente/Documentación_Linux.ms -T pdf > ~/Documentos/Anotaciones/Documentación_Linux.pdf
groff -ms -D UTF-8 ~/Documentos/Anotaciones/Ficheros\ Fuente/Atajos.ms -T pdf > ~/Documentos/Anotaciones/Atajos.pdf
if test $1 -eq 1; then
	mupdf ~/Documentos/Anotaciones/Documentación_Linux.pdf
else
	mupdf ~/Documentos/Anotaciones/Atajos.pdf
fi
