#!/usr/bin/python
# -*- coding: utf-8 -*-
 
import sys
import csv
  
#La ejecucion del programa necesita argumentos
if len(sys.argv) < 3:
    print "\nError en la ejecución. Debes introducir: programa.py ficheroCSV ficheroHTML\n"
    exit(1)
 
#Abrimos el archivo CSV comprobando que exista
try:
	archivoCSV = csv.reader(open(sys.argv[1]))
except:
	print "\nEl archivo CSV que intenta abrir, no existe.\n"
	exit (0)
 
#Creamos el archivo de salida HTML
archivoHTML = open(sys.argv[2],"w")
 
#Inicializamos numfilas para contar cuantas filas hay en el CSV
numfilas = 0
 
#Escribimos el principio de la etiqueta de la tabla
archivoHTML.write('<table border=1 cellspacing=0 cellpadding=2>\n')
 
#Generamos el contenido de las tablas
for fila in archivoCSV:
 
    if numfilas == 0:
        archivoHTML.write('\t<tr>')
        for col in fila:
            archivoHTML.write('\n\t\t<th align=middle>' + col + '</th>')
        archivoHTML.write('\n\t</tr>\n')
 
    else:
        archivoHTML.write('\t<tr>')   
        for col in fila:
            archivoHTML.write('\n\t\t<td align=middle>' + col + '</td>')
        archivoHTML.write('\n\t</tr>\n')
     
    #Incrementamos el numero de filas   
    numfilas += 1
 
#Escribimos el final de la etiqueta de la tabla
archivoHTML.write('\n</table>')
 
#Mensaje por consola para saber cuantas filas hemos escrito en la tabla
print "\nEscritas en el archivo" + str(numfilas) + " filas en forma de tabla.\n"
exit(0)

