#!/usr/bin/python
# -*- coding: utf-8 -*-

miLista = [];
print "Vamos a comparar dos números.\n";
x = raw_input('Introduce el primer número: ');
while x.isdigit() == False:
  x = raw_input('No has introducido un número. Por favor, introduce el primer número: ');

y = raw_input('Introduce el segundo número: ');
while y.isdigit() == False:
  x = raw_input('No has introducido un número. Por favor, introduce el segundo número: ');

if int(x) > int(y):
  print x," mayor que ",y;
  
elif int(x) < int(y):
    print x," menor que ",y;
    
else: print x," igual que ",y;