#!/usr/bin/gnuplot
# set terminal x11
# Comentar la linea de arriba y descomentar las dos de abajo para producir .png
# La imagen se podría ver luego con display pi-2.9-266.png
  set terminal png
  set output 'Resultados V3.png'

# O descomentar estas de abajo para producir fichero .eps
#set terminal postscript eps color
#set output 'pi-2.9-266.eps'

set label "Tiempos de ejecucion y Escalabilidad del Programa pi en el Aula 3.3 1.80GHz" \
	at screen 0.5,0.9 center

set multiplot

set xlabel "Nº Computadores"
#set xtics 1
#set ytics 0.5
#set mytics 5
set grid
#set grid mytics

set title "Tiempo"
set ylabel "Tiempo de ejecucion (s)"
set size   0.50,0.80
set origin 0.00,0.05
plot	"ResV3.txt"	title "Version3"	with lp

TV3=`awk '$1 ~ /^1$/ {print $2;}' ResV3.txt`

set title "Ganancia"
set ylabel "Ganancia - relativa a Tpar(1)"
set size   0.50,0.80
set origin 0.50,0.05
set key left
plot "ResV3.txt" using 1:(TV3/$2)	title "Version3" with lp


set nomultiplot

reset

