#!/usr/bin/python
# -*- coding: utf-8 -*-

def calcula_media(*args):
    total = 0;
    for i in args:
        total += i;
    resultado = total / len(args);
    return resultado;

a, b, c = 3, 5, 10;
media = calcula_media(a, b, c);
print "La media de",a,",",b,"y",c,"es:", media;

a, b = 3, 5;
media = calcula_media(a, b);
print "La media de",a,"y",b,"es:", media;