#!/usr/bin/python
# -*- coding: utf-8 -*-

cont_tablas = 2;

while cont_tablas < 11:
  
  cont_operaciones = 0;
  print "______________";
  print "TABLA DEL ",cont_tablas;
  print "______________";
  
  while cont_operaciones < 11:
    
    res = cont_tablas*cont_operaciones;
    print cont_tablas, "*",cont_operaciones,"=",res;
    cont_operaciones += 1;
   
  cont_tablas += 1;