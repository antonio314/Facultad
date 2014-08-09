#!/usr/bin/python
# -*- coding: utf-8 -*-

class cuenta_bancaria():
  
  def __init__(self):
  	self.titular = "Jose Antonio Guerrero Aviles";
  	self.num_cuenta = "123456789";
  	self.saldo = 0;
  	self.movimientos = [];
  	self.total_mov = 0;
  
  def getTitular(self):
  	return self.titular;
    
  def getSaldo(self):
  	return self.saldo;
    
  def getNumCuenta(self):
  	return self.num_cuenta;
    
  def ingresar(self,cantidad):
  	self.saldo += cantidad;
	self.total_mov += 1;
	self.movimientos.append(str(self.total_mov)+'.- Ingreso:'+str(cantidad)+' | Saldo:'+str(self.saldo));
	print "Ingreso realizado correctamente\n";

  def retirar(self,importe):
	if self.saldo > importe:
		self.saldo -= importe;
		self.total_mov += 1;
		self.movimientos.append(str(self.total_mov)+'.- Retirada:'+str(importe)+' | Saldo:'+str(self.saldo));
		print "Retirada realizada correctamente\n";
	else: print "Saldo insuficiente.\n";
    
  def listar_movimientos(self):
	print "\nMovimientos";
	print "-----------\n"
	for mov in self.movimientos:
		print mov;
		print "_______________________________\n";

      
###################### COMIENZO DEL PROGRAMA ######################
opc = -1;
miCuenta = cuenta_bancaria();

while opc != 0:
  
  print "------------------------";
  print "1. Consultar Saldo.";
  print "2. Realizar ingreso.";
  print "3. Sacar dinero.";
  print "4. Listar movimientos.";
  print "5. Consultar titular.";
  print "6. Consultar numero de cuenta.";
  print "0. Salir";
  print "-------------------------";
  opc = int(raw_input('Elija una opción:'));
  
  if opc == 1:
    print "Su saldo es", miCuenta.getSaldo();
    print "\n";
    
  elif opc == 2:
    c = raw_input('Introduce el importe del ingreso:');
    miCuenta.ingresar(float(c));
    
  elif opc == 3:
    i = raw_input('Introduce el importe de la retirada:');
    miCuenta.retirar(float(i));
  
  elif opc == 4:
    miCuenta.listar_movimientos();
    
  elif opc == 5:
    print "El titular de la cuenta es",miCuenta.getTitular();
    print "\n";
    
  elif opc == 6:
    print "El numero de cuenta es",miCuenta.getNumCuenta();
    print "\n";
    
  elif opc == 0:
    print "Hasta pronto.";
    print "\n";

    
    
    
    
    
    
    
    
    
    
    
    
    
    
