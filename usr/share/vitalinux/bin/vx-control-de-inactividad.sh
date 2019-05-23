#!/bin/bash

function aviso-accion-inactividad {
	for i in {1..100}; do 
	   echo "$i" 
	   sleep 0.2 
	done | zenity --progress \
	          --window-icon tiempo-inactividad \
	          --title "Cuenta Atrás para el Apagado del Equipo" \
	          --text " ${TEXTO} \n Dispones de 20sg ... <b>PARA ABORTAR, CLICK EN CANCELAR!</b> " \
	          --percentage=0 \
	          --auto-close || sudo /sbin/init 0
	if test $? -ne 0 ; then
	  zenity --info --text="¡¡Acción Abortada por el usuario!!"
	  # exit 0
	  DECISION=1
	fi
}

function accion-por-inactividad {
	DECISION=0
	case ${1} in
		"0" ) 	TEXTO="${TEXTO}\n=> <b>Apagar el Equipo</b>\n"
				aviso-accion-inactividad
				if test "${DECISION}" -eq 0 ; then
					sudo /sbin/init 0
				fi
				 ;;
		"1" ) 	TEXTO="${TEXTO}\n=> <b>Cerrar Sesión (cerrando aplicaciones)</b>\n"
				aviso-accion-inactividad
				if test "${DECISION}" -eq 0 ; then
					lxsession # kill -u "${USUARIO}"
				fi
				;;
		"2" ) 	TEXTO="${TEXTO}\n=> <b>Cerrar Sesión (sin cerrar aplicaciones)</b>\n"
				aviso-accion-inactividad
				if test "${DECISION}" -eq 0 ; then
					dm-tool lock # dm-tool switch-to-greeter 
				fi
				;;
	esac
}

FICHLOG="/var/log/vitalinux/vx-accion-por-inactividad.log"
mv "${FICHLOG}" "/var/log/vitalinux/vx-accion-por-inactividad.ant.log"
echo "" > "${FICHLOG}"

while test 1 -eq 1 ; do
USUARIO="$(vx-usuario-grafico)"
. /etc/default/vx-dga-variables/vx-dga-l-control-de-inactividad.conf
TEXTO="Ante la inactividad del usuario se procederá a aplicar la siguiente acción:"

	TIEMPO="$(export DISPLAY=:0 && su "${USUARIO}" -c 'xprintidle' --login)"
	if test "${TIEMPO_INACTIVIDAD}" -gt 0 ; then 
		if test "${TIEMPO}" -ge "${TIEMPO_INACTIVIDAD}" ; then
			echo "==> $(date): Transcurrido el Tiempo de Inactividad ${TIEMPO_INACTIVIDAD} se llevará acabo la acción ${ACCION_TRAS_INACTIVIDAD} ..." >> "${FICHLOG}"
			accion-por-inactividad "${ACCION_TRAS_INACTIVIDAD}"
		else
			echo "=> Hay programada una acción ante la Inactividad del usuario ${USUARIO}, pero aún no ha llegado a su limite:" > "${FICHLOG}"
			echo "==> Tiempo de Inactividad del usuario ${USUARIO}: ${TIEMPO}" >> "${FICHLOG}"
			echo "==> Tiempo programado de Inactividad antes de desencadenar la acción: ${TIEMPO_INACTIVIDAD}" >> "${FICHLOG}"
			echo "==> Acción tras la Inactividad: ${ACCION_TRAS_INACTIVIDAD}" >> "${FICHLOG}"
		fi
	else
		echo "=> $(date): No hay programada ninguna acción ante la inactividad del equipo ... esperaremos 60sg para volver a comprobarlo." > "${FICHLOG}"
	fi
	sleep 15
done