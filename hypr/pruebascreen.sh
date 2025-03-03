#!/bin/bash

# Directorio donde se guardarán las capturas
DIRECTORIO=~/Imágenes/screenshots

# Crear el directorio si no existe
mkdir -p "$DIRECTORIO"

# Menú de opciones con wofi
selected=$(echo -e "Captura completa\nCaptura área seleccionada" | wofi --dmenu --width 300 --height 200)

# Obtener la fecha y hora actual para nombrar el archivo
timestamp=$(date +\%Y\%m\%d\%H\%M\%S)

# Ejecutar el comando según la opción seleccionada
case "$selected" in
    "Captura completa")
        # Captura de pantalla completa
        grim "$DIRECTORIO/screenshot-$timestamp.png" && grim - | wl-copy && notify-send "Captura completa guardada y copiada al portapapeles"
        ;;
    "Captura área seleccionada")
        # Captura de área seleccionada
        grim -g "$(slurp)" "$DIRECTORIO/screenshot-$timestamp.png" && grim -g "$(slurp)" - | wl-copy && notify-send "Captura seleccionada guardada y copiada al portapapeles"
        ;;
    *)
        # Si no se selecciona ninguna opción válida
        notify-send "Opción no válida"
        ;;
esac
