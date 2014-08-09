#!/usr/bin/python
# -*- coding: utf-8 -*-

continuar = 0;
contador = 0;
res = '';

while continuar == 0:
  
  cadena = raw_input("Introduce palabra: ");
  if(cadena == 'Basta' or cadena == 'basta' or cadena == ''):
    break
  contador += 1;
  res = res + " " + cadena;
  print "Has introducido hasta el momento:",res;
  
print "Has soportado estoicamente ",contador," preguntas.";
  