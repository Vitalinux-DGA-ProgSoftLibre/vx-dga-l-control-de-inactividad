# Paquete DEB vx-dga-l-control-de-inactividad

Paquete creado con la finalidad de poder programar una acción tras un periodo de inactividad del usuario.  De momento, a falta de una demanda por parte de los usuarios, tan sólo estan pensadas tres posibles acciones, pudiendose ampliar en un futuro:

1) Apagar el equipo
2) Cerrar Sesión cerrando todas las aplicaciones al usuario activo
3) Cerrar Sesión manteniendo todas las aplicaciones del usuario abiertas

Se proporcionan dos lanzadores disponibles en el menú de Utilidades/Utilities:

1) **Deshabilitar Control de Inactividad**: Deshabilita para la sesión actual el control de inactividad.
2) **Programar Inactividad del Sistema**: Permite configurar el tiempo máximo de inactividad y la acción que se desencadenará una vez transcurrido ese tiempo.

# Usuarios Destinatarios

Profesores, alumnos, y demás usuarios que adviertan que se quedan sus equipos arrancados con periodos de inactividad excesivamente largos

# Aspectos Interesantes:

La configuración del tiempo o periodo de inactividad y la acción que se desencadenará transcurrido dicho tiempo se puede llevar a cabo de dos formas:

1) De manera remota y desatendida a través de Migasfree.  En función del etiquetado Migasfree del equipo se le configurarán un tiempo y una acción
2) De manera interactiva mediante el uso de una pequeña aplicación que incorpora el paquete para que el usuario pueda personaliza tanto el tiempo como la acción. En el caso de disponer de synapse (preinstalado en Vitalinux) será tan sencillo acceder a ella como teclear CONTROL + ESPACIO y escribir "inactividad ..."

# Como Crear o Descargar el paquete DEB a partir del codigo de GitHub
En caso de querer modificar y mejorar el paquete, será necesario crear de nuevo el paquete.  Para crear el paquete DEB será necesario encontrarse dentro del directorio donde localizan los directorios que componen el paquete.  Una vez allí, se ejecutará el siguiente comando (es necesario tener instalados los paquetes apt-get install debhelper devscripts):

```
apt-get install debhelper devscripts
/usr/bin/debuild --no-tgz-check -us -uc
```

En caso de no querer crear el paquete para tu distribución, si simplemente quieres obtenerlo e instalarlo, puedes hacer uso del que está disponible para Vitalinux (*Lubuntu 14.04*) desde el siguiente repositorio:

[Respositorio de paquetes DEB de Vitalinux](http://migasfree.educa.aragon.es/repo/Lubuntu-14.04/STORES/base/)

# Como Instalar el paquete vx-dga-l-*.deb:

Para la instalación de paquetes que estan en el equipo local puede hacerse uso de ***dpkg*** o de ***gdebi***, siendo este último el más aconsejado para que se instalen de manera automática también las dependencias correspondientes.
```
gdebi vx-dga-l-*.deb
```

