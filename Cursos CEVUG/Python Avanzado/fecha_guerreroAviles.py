#!/usr/bin/python
# -*- coding: utf-8 -*-


import re

cadena = raw_input('Introduce una fecha: ');

patron = '^[\w\s]+\d{1,2}\/(Ene|Feb|Mar|Abr|May|Jun|Jul|Ago|Sep|Oct|Nov|Dic)\/\d{4}\s\d{1,2}\:\d{2}\s[PA]M$'

if re.match(patron, cadena):
    print ("Es una fecha correcta")
else:
    print ("Fecha incorrecta. Debe tener el siguiente formato: Granada 5/Ago/2012 2:23 AM ")
