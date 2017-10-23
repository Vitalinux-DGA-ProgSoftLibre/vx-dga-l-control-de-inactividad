#!/bin/bash

USUARIO="$(vx-usuario-grafico)"
export DISPLAY=:0 && su "${USUARIO}" \
	-c 'sudo /sbin/start-stop-daemon --start --oknodo --quiet -b --exec /usr/share/vitalinux/bin/vx-control-de-inactividad.sh' --login