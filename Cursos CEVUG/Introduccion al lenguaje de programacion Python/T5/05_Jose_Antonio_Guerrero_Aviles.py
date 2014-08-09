#!/usr/bin/python
# -*- coding: utf-8 -*-

import urllib2
 
def gethtml(url):
	try:
		req = urllib2.Request(url);
		return urllib2.urlopen(req).read();

	except Exception, e:
		return "Error al descargar la web. Compruebe la conexión o la dirección";

url = raw_input('Introduzca el enlace de la Web que desea descargar:');
codigo = gethtml(url);

#Guardo el codigo descargado o el error en el fichero
fichero = open("HTMLdescargado.txt","a+"); #a+ abre el archivo para lectura y escritura, si no existe lo crea, 
					   #además anexa al contenido que tenga ya el archivo.

fichero.write(url);
fichero.write("\n______________________________________________________________________________________________\n");
fichero.write(codigo);
fichero.write("\n\n/////////////////////////////////////////////////////////////////////////////////////////////\n\n");

fichero.close();

print "Archivo generado.";
    
    
    
    
    
    
    
    
    
    
    
    
    
