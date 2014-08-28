#!/usr/bin/python
# -*- coding: utf-8 -*-

import MySQLdb
#myId = 0;
cont = 0;
listaNombres = ["n1","n2","n3","n4","n5","n6","n7","n8","n9","n10"];
listaProfesiones = ["p1","p2","p3","p4","p5","p6","p7","p8","p9","p10"];
listaMuertes = ["m1","m2","m3","m4","m5","m6","m7","m8","m9","m10"];

Conexion = MySQLdb.connect(host='localhost', user='conan',passwd='crom', db='DBdeConan')
micursor = Conexion.cursor()

queryID = 'SELECT id FROM Victimas;'
ids = micursor.execute(queryID)
myId = ids

while myId < 10 + ids :
	myId = myId+1
	query= 'INSERT INTO Victimas (id,Nombre,Profesion,Muerte) VALUES ('+str(myId)+'," '+listaNombres[cont]+' "," '+listaProfesiones[cont]+' "," '+listaMuertes[cont]+' ");'
	cont = cont+1
	micursor.execute(query)
	Conexion.commit()


opc = 1

while (opc == 1):

	nombre = ""
	profesion = ""
	muerte = ""
	while nombre == "":
		nombre = raw_input('Introduce el nombre de la victima (no puede estar vacio): ');

	while profesion == "":
		profesion = raw_input('Introduce la profesion de la victima (no puede estar vacio): ');

	while muerte == "":
		muerte = raw_input('Introduce la muerte de la victima (no puede estar vacio): ');

	myId = myId+1
	query= 'INSERT INTO Victimas (id,Nombre,Profesion,Muerte) VALUES ('+str(myId)+'," '+str(nombre)+' "," '+str(profesion)+' "," '+str(muerte)+' ");'
	cont = cont+1
	micursor.execute(query)
	Conexion.commit()

	opc = raw_input('¿Quieres introducir una nueva victima? (1 = SI / 0 = NO): ');
	opc = int(opc)	


micursor.close()
Conexion.close()


