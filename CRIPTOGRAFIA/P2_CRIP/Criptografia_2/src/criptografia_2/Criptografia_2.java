/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package criptografia_2;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author José Antonio Guerrero 
 */
public class Criptografia_2 {

    
    
    public static int charToInt(char c)
    {
        //necesito pasar un char a int, para ello: char->char[]->String->int
        char[] rc = new char[1];
        rc[0] = c;
        String saux = new String(rc); 
        int resultado = Integer.parseInt( saux );
        
        return resultado;
    }
    
    
    public static char XOR(char a, char b)
    {
        
        char res;
        
        if(a==b && b=='0')
        {
            res = '0';
        }
        else if(a==b && b=='1')
        {
            res = '0';
        }
        else 
        {
            res = '1';
        }
        return res;
        
    }
    
    public static char AND(char a, char b)//producto para la mezcla
    {
        
        char res;
        
        if(a=='0' || b=='0'){
            res = '0';
        }
        
        else {
            res = '1';
        }
        return res;
        
    }
    
    public static char OR(char a, char b)//suma para la mezcla
    {
        
        char res;
        
        if((a=='1' && b=='1') || (a=='0' && b=='0'))
        {
            res = '0';
        }
        else 
        {
            res = '1';
        }
        return res;
        
    }
    
    
    //recibe un ArrayList de char (con enteros) y devuelve el int asociado
    public static int arrayListDeEnterosToInt( ArrayList s )
    {
        
        int pos=10;
        int cont=s.size()-1;

        int resultado = charToInt( (char)s.get(cont) );
                
        cont--;
        
        while( cont>=0 )    //bucle decreciente
        {
            
            //paso el char leido a int
            int aux = charToInt( (char)s.get(cont) );
                    
            resultado = resultado + aux*pos;
            
            pos=pos*10;
            cont--;
        }
        
        return resultado;
    }
    
    //recibe un ArrayList de char (solo con 0 y 1) y lo transforma en un int que devuelve
    public static int arrayListToInt( ArrayList registro )
    {
        
        int resultado=0;
        
        int aux=64, i=0;
        
        while( i<registro.size() )
        {
            int r;
            if(registro.get(i)=='0')
            {
                r=0;
            }
            else
            {
                r=1;
            }
            
            resultado = resultado + aux*r;
            aux = aux/2;
            i++;
        }
            
        return resultado;
    }
    
    
    //funcion que lee un fichero con el formato de entrada de minterms y devuelve un ArrayList de int
    public static ArrayList leerMinterms( String nombre_fichero_minTerms ) throws FileNotFoundException, IOException
    {
              
        ArrayList minTerms = new ArrayList();
        
        //abrimos el fichero pasado con los minterms
        File fE = new File( nombre_fichero_minTerms );     
        FileInputStream ficheroEntrada = new FileInputStream( fE );
        
        boolean fin=false;
        boolean quedanMinterms=true;
        char c;
        ArrayList aux= new ArrayList();  //ArrayList de char donde ire metiendo las cifras del numero que se esta leyendo en ese momento
        
        while(!fin)
        {
            //leo el caracter del fichero
            c = (char)ficheroEntrada.read();
            
                        
            if(c==',')  //si he llegado a una ',' paso lo que tenga en el ArrayList auxiliar a int y lo meto en minterms
            {
                //paso a int y lo meto en minterms
                minTerms.add( arrayListDeEnterosToInt(aux) );         

                //limpio el contenido de aux
                aux.clear();                    

            }
            else if( c=='1' || c=='2' || c=='3' || c=='4' || c=='5' || c=='6' || c=='7' || c=='8' || c=='9' || c=='0' )
            {
                aux.add(c); //mete esa cifra al final del arraylist
            }

            
            if( ficheroEntrada.available() == 0 )
            {
                fin=true;
            }
            
        }
        
        
        //para que tambien pase el ultimo minterm (no va seguido de una ',')
        minTerms.add( arrayListDeEnterosToInt(aux) );         

        //limpio el contenido de aux
        aux.clear(); 
        
        
        return minTerms;
        
    }
    
    
    //devuelve un fichero que sera una secuencia de 0s y 1s seguidos
    public static void NLFSR( String nombre_fichero_minTerms, String semilla, int numBitsGenerar ) throws FileNotFoundException, IOException
    {

        //abrimos el fichero de salida que vamos a crear
        File fS = new File( "salida_NLFSR.txt" );     
        FileOutputStream ficheroSalida = new FileOutputStream( fS );
        
        ArrayList minterms = leerMinterms( nombre_fichero_minTerms );

        
        
        //meto en la tabla hash los minterms
        HashMap funcion = new HashMap();  //<llave,resultado>     
        int cont=0;
        while(cont<minterms.size())
        {
            funcion.put( minterms.get(cont), true );            
            cont++;            
        }
        
        //una vez que tenemos creado el hashtable, creamos un ArrayList con el registro y lo inicializamos con la semilla pasada
        ArrayList registro = new ArrayList();
        
        registro.add(semilla.charAt(0));
        registro.add(semilla.charAt(1));
        registro.add(semilla.charAt(2));
        registro.add(semilla.charAt(3));
        registro.add(semilla.charAt(4));
        registro.add(semilla.charAt(5));
        registro.add(semilla.charAt(6));
        
        
        for(int contBits=0; contBits<numBitsGenerar-7; contBits++)
        {
            
            
            int valorRegistro = arrayListToInt(registro);
            
            //metemos en ficheroSalida la cabecera del registro
            ficheroSalida.write( (char)registro.get(0) );
            
            //System.out.println( registro.get(0) );
            
            registro.remove(0);
            
            
            //primero pasamos el valor del registro a int y comprobamos si esta en "funcion"
            if( funcion.containsKey(valorRegistro) )
            {
                //metemos un 1 en el registro
                registro.add('1');
            }
            else
            {
                //metemos un 0 en el registro
                registro.add('0');
            }
            
        }
        
        for(int i=0; i<7; i++)
        {
            //metemos en ficheroSalida el valor de registro (7 ultimos bits)

            //System.out.println(registro.get(i));
            ficheroSalida.write( (char)registro.get(i) );
            
        }

    }
    
    
    
    
    
    
    public static void LFSR( int numCeldas, String polinomio, String semilla, int numBitsGenerar ) throws FileNotFoundException, IOException
    {
    

        //abrimos el fichero de salida que vamos a crear
        File fS = new File( "salida_LFSR.txt" );     
        FileOutputStream ficheroSalida = new FileOutputStream( fS );
        
        //una vez que tenemos creado el hastable, creamos un ArrayList con el registro y lo inicializamos con la semilla pasada
        ArrayList registro = new ArrayList();
        
        for(int i=0; i<numCeldas; i++)
        {
            registro.add(semilla.charAt(i));
        }

        
        char bitResultante;
        
        for(int contBits=0; contBits<numBitsGenerar-numCeldas; contBits++)
        {
            
            bitResultante = 'a';
            
            for(int i=0; i<numCeldas; i++)
            {
                if( polinomio.charAt(i)=='1' )
                {
                    
                    if(bitResultante=='a')
                    {
                        bitResultante=(char)registro.get(i) ;
                    }
                    else
                    {
                        bitResultante = XOR( bitResultante, (char)registro.get(i) );                    
                    }
                    
                }
            }
            
            //ya tenemos el bitResultante de hacer el XOR con todos los valores del registro indicados por el polinomio
   
            
            //metemos en ficheroSalida la cabecera del registro
            ficheroSalida.write( (char)registro.get(0) );
            
            registro.remove(0);
            
            //ahora metemos el bitResultante al final del registro
            registro.add(bitResultante);
            
            
        }
        
        for(int i=0; i<numCeldas; i++)
        {
            //metemos en ficheroSalida el valor de registro (numCeldas ultimos bits)
            ficheroSalida.write( (char)registro.get(i) );
        }

        
    }
    
    public static void Golomb(String nombreFichero) throws FileNotFoundException, IOException{

        boolean postulado1 = false, postulado2 = false, postulado3 = true;

        //abrimos el fichero pasado
        File fE = new File( nombreFichero );     
        FileInputStream ficheroEntrada = new FileInputStream( fE );

        char c='a';
        
        String semilla="";
        
       
        
        while(ficheroEntrada.available() != 0)
        {

            //leo el caracter del fichero
            c = (char)ficheroEntrada.read();

            //voy a pasar char->string
            char[] rc = new char[1];
            rc[0] = c;
            String saux = new String(rc); 
            
            semilla = semilla.concat((String)saux);     
            
        }
        
        ArrayList pivote = new ArrayList();

        int tamanoSemilla = semilla.length();

        int unos = 0;

        int ceros = 0;

        for(int i = 0;i < tamanoSemilla;i++){

            if(semilla.charAt(i) == '0')

                ceros++;
            else
                unos++;
        }

        if(ceros-unos <= 1 && ceros-unos >= -1){

            postulado1 = true;

        }
        //comprobamos el segundo postulado
        
       
        
        
        //comprobamos el tercer postulado
        
        int distanciaHamming=0;

        // copiamos la semilla en pivote que sera el vector que utilizaremos para hacer shift

        for(int i = 0;i < tamanoSemilla;i++){

            pivote.add(semilla.charAt(i));

        }

        //el primero de la izda va hacia la dcha
        pivote.add(pivote.get(0));
        pivote.remove(0);

        distanciaHamming = 0;

        //calculo la distancia de hamming del pivote actual con la semilla
        for(int i = 0;i < tamanoSemilla;i++){

            if((char)pivote.get(i) != semilla.charAt(i)){


                distanciaHamming++;

            }

        }

        for(int j = 0;j < tamanoSemilla -2;j++){

            int distancia = 0;

            //el primero de la izda va hacia la dcha
            pivote.add(pivote.get(0));
            pivote.remove(0);

            for(int i = 0;i < tamanoSemilla;i++){

                if((char)pivote.get(i) != semilla.charAt(i)){

                    distancia++;


                }

            }

            if(distancia != distanciaHamming){

                postulado3 = false;

            }

        }

        if(postulado1 == true){

            System.out.println("Se cumple el postulado 1 de Golomb");

        }
        
        else{
            
            System.out.println("No se cumple el postulado 1 de Golomb");
        
        }
        
        if(postulado2 == true){

            System.out.println("Se cumple el postulado 2 de Golomb");

        }
        
        else{
            
            System.out.println("No se cumple el postulado 2 de Golomb");
        
        }
                
        if(postulado3 == true){

            System.out.println("Se cumple el postulado 3 de Golomb");

        }
        
        else{
            
            System.out.println("No se cumple el postulado 3 de Golomb");
        
        }

    }

  /*public static int berlekampMassey(int[] array) {
      
        int N = array.length;
        int[] b = new int[N];
        int[] c = new int[N];
        int[] t = new int[N];
        b[0] = 1;
        c[0] = 1;
        int l = 0;
        int m = -1;
        int j;
        
        for (int n = 0; n < N; n++) {
            int d = 0;
            for (int i = 0; i <= l; i++) {
                d ^= c[i] * array[n - i];
            }
            if (d == 1) {
                
                System.arraycopy(c, 0, t, 0, N);
                
                int NM;
                NM=n-m;
                
                for (j=0; j<N-NM; j++) {
                    c[NM + j] ^= b[j];
                }
                if (l <= n / 2) {
                    l = n + 1 - l;
                    m = n;
                    System.arraycopy(t, 0, b, 0, N);
                }
            }
        }
        return l;
    }*/
    
    public static void berlekampMassey(String nomFich) throws FileNotFoundException, IOException {
        
        //abrimos el fichero pasado
        File fE = new File( nomFich );     
        FileInputStream ficheroEntrada = new FileInputStream( fE );

        char ca='a';

        String secuencia="";



        while(ficheroEntrada.available() != 0)
        {

            //leo el caracter del fichero
            ca = (char)ficheroEntrada.read();

            //voy a pasar char->string
            char[] rc = new char[1];
            rc[0] = ca;
            String saux = new String(rc); 

            secuencia = secuencia.concat((String)saux);     

        }

        //compruebo si el fichero tiene al final un '\n'
        if(secuencia.charAt(secuencia.length()-1) =='\n' )
        {
            secuencia = secuencia.substring(0, secuencia.length()-1);
        }

        char[] aux = new char[secuencia.length()];
        int[] s = new int[secuencia.length()];

        aux=secuencia.toCharArray();

        for(int i=0; i<secuencia.length();i++){

            s[i]=aux[i]-48;

        }
        
        System.out.println("La sucesión leída es: ");
        for(int i=0; i<s.length;i++){System.out.print(s[i]);}
        
        //cuerpo del algoritmo
      
        int r=0, L=0, d=0, m=-1, aux2=0;
        int[] b = new int[s.length];
        int[] c = new int[s.length];
        int[] aux1 = new int[s.length];
        
        b[0]=1;
        c[0]=1;
        
        for(int i=1; i<s.length; i++){
            
            b[i]=0;
            c[i]=0;
        
        }
        
        while(r<s.length){
            
            d=0;
            
            for(int i=0; i < r; i++){
 
                    d=d+s[i]*c[r-i];

                
                if(d==1){
                    
                    for(int k=0; k < r; k++){
 
                        aux1[k]=c[k];
                        
                    }
                
                    aux2=s.length - r + m - 1;
                    
                    for (int j=0; j<aux2; j++){
                        
                        if(c[j+1] +b[j]>1){
                        
                            c[j+1]=0;
                        }
                        else{
                            
                            c[j+1] = c[j+1] +b[j]; 
                            
                        }

                    }
                    if(L<=r/2){
                        
                        L=r-L+1;
                        r=r+1;
                        
                        for(int z=0; z < r; z++){
 
                            b[z]=aux[z];
                        
                        }
                    }
                }     
            }
            
            r=r+1;
        }
        
        System.out.println("\n\nLongitud mínima que genera la sucesión: "+L);
        
        /*System.out.println("\nEl polinomio generador es: ");
        
        for(int cont=1; cont<c.length; cont++){
       
            
                System.out.print(c[cont]);
            
        }*/
        
    }

    public static void periodo(String nombreFicheroEntrada) throws IOException{

        
        //abrimos el fichero pasado
        File fE = new File( nombreFicheroEntrada );     
        FileInputStream ficheroEntrada = new FileInputStream( fE );

        char c='a';
        
        String secuencia="";
        
       
        
        while(ficheroEntrada.available() != 0)
        {

            //leo el caracter del fichero
            c = (char)ficheroEntrada.read();

            //voy a pasar char->string
            char[] rc = new char[1];
            rc[0] = c;
            String saux = new String(rc); 
            
            secuencia = secuencia.concat((String)saux);     
            
        }
       
        //compruebo si el fichero tiene al final un '\n'
        if(secuencia.charAt(secuencia.length()-1) =='\n' )
        {
            secuencia = secuencia.substring(0, secuencia.length()-1);
        }
        
        
      
        int tope = secuencia.length()/ 2;

        boolean periodo = false;

        
        //abrimos el fichero de salida que vamos a crear
        File fS = new File( "periodo_salida.txt" );     
        FileOutputStream ficheroSalida = new FileOutputStream( fS );
        
        
        String parte = "";

        for(int i = 2;i <= tope && periodo == false;i++){

            parte = secuencia.substring(0, i);

            periodo = true;

            int j = 0;
            int w = i;
            

            

            while(w + i  <= tope * 2){

                j = j + i;
                w = w + i;

                
                
                if(!parte.equals(secuencia.substring(j, w)))

                    periodo = false;

            }

            
            
            if(periodo){    //comprueba hasta el final del archivo
                
               
                
                for(int h = w;h < tope*2;h++){

                    if(parte.charAt(h-w) != secuencia.charAt(h)){

                        periodo = false;
                        

                    }

                }
            }



        }


        if(periodo){

            for(int i=0; i<parte.length(); i++)
            {
                ficheroSalida.write( (char)parte.charAt(i) );
            }
            
            System.out.println("Se ha creado un fichero con los resultados de salida, su nombre es: periodo_salida.txt");
            System.out.println("El periodo tiene un tamaño de "+parte.length());
            
        }
        else{

        System.out.println("No hay periodo, luego no se ha creado el fichero");

        }


    }

   
    
    
    public static void main(String[] args) throws FileNotFoundException, IOException {

        
        
        BufferedReader teclado = new BufferedReader(new InputStreamReader(System.in));

        String opc,opc2;

        do{
            
        
            System.out.println("\nElige el calculo que deseas realizar: \n"
                    + "1. NLFSR \n"
                    + "2. LFSR \n"
                    + "3. Golomb \n"
                    + "4. Periodo \n"
                    + "5. Berlekamp–Massey \n"
                    + "6. Mezcla \n"
                    + "0. Salida\n"
                    + "Opcion: ");

            
            opc = teclado.readLine();

            
            if(opc.equals("0") )
            {
                System.out.println("FIN DEL PROGRAMA\n");
            }


            if(opc.equals("1")){


                System.out.println("NLFSR\n");

                System.out.println("Introduce el nombre del archivo donde se guardan los minterms: ");
                String nom_fich = teclado.readLine();

                System.out.println("Introduce un valor para la semilla: ");
                String semilla = teclado.readLine();

                System.out.println("Introduce el numero de bits a generar: ");
                String numElem = teclado.readLine();


                NLFSR(nom_fich, semilla, Integer.parseInt(numElem) );

                System.out.println("Se ha creado un fichero con los resultados de salida, su nombre es: salida_NLFSR.txt");
            }
            
            if(opc.equals("2")){


                System.out.println("LFSR\n");

                System.out.println("Introduce el numero de bits de la semilla: ");
                String numCeldas = teclado.readLine();

                
                System.out.println("Introduce los coeficientes del polinomio: ");
                String polinom = teclado.readLine();

                
                System.out.println("Introduce un valor para la semilla: ");
                String semilla = teclado.readLine();

                System.out.println("Introduce el numero de bits a generar: ");
                String numElem = teclado.readLine();

                LFSR( Integer.parseInt(numCeldas), polinom, semilla, Integer.parseInt(numElem) );

                System.out.println("Se ha creado un fichero con los resultados de salida, su nombre es: salida_LFSR.txt");
            }
            

            if(opc.equals("3")){


                System.out.println("POSTULADOS DE GOLOMB \n");

                
                System.out.println("Introduce el nombre del fichero: ");
                String nomFich = teclado.readLine();


                Golomb( nomFich );
            }
            if(opc.equals("4")){


                System.out.println("PERIODO \n");


                System.out.println("Introduce el nombre del fichero: ");
                String nomFich = teclado.readLine();


                periodo( nomFich );

            }
            
            if(opc.equals("5")){
            
            System.out.println("BERLEKAMP–MASSEY \n");
            
            System.out.println("Introduce el nombre del fichero: ");
            String nomFich = teclado.readLine();
            

            
            berlekampMassey(nomFich); 
            
            
            }
            
            if(opc.equals("6")){
                
                do{
            
                System.out.println("\nMEZCLA \n");
                           System.out.println("\nElige el calculo que deseas realizar: \n"
                    + "1. Suma \n"
                    + "2. Producto \n"
                    + "0. Salida\n"
                    + "Opcion: ");

            
                opc2 = teclado.readLine();


                if(opc2.equals("0") )
                {
                    System.out.println("FIN DEL PROGRAMA\n");
                }

                if(opc2.equals("1") ){

                    String a1;
                    String b1;
                    char[] a, b;
    
                    
                    System.out.println("SUMA\n");
                    
                    System.out.println("Introduce la primera secuencia: ");
                    a1 = teclado.readLine();
                    
                    
                    System.out.println("\n Introduce la segunda secuencia: ");
                    b1 = teclado.readLine();
                   
                    a = a1.toCharArray();
                    b = b1.toCharArray();
                    
                   System.out.println("\nLa suma es: ");
                  
                    
                    for(int i =0; i< a1.length(); i++){
                        
                           System.out.print(OR(a[i],b[i]));
                    }
 
                }

                if(opc2.equals("2") ){

  
                    String a1;
                    String b1;
                    char[] a, b;
    
                    
                    System.out.println("PRODUCTO\n");
                    
                    System.out.println("Introduce la primera secuencia: ");
                    a1 = teclado.readLine();
                    
                    
                    System.out.println("\nIntroduce la segunda secuencia: ");
                    b1 = teclado.readLine();
                   
                    a = a1.toCharArray();
                    b = b1.toCharArray();
                    
                   System.out.println("\nEl producto es: ");
                  
                    
                    for(int i =0; i< a1.length(); i++){
                        
                           System.out.print(AND(a[i],b[i]));
                    }


                }
                
                }while (!opc2.equals("0"));
            
            }
            
        }while(opc.equals("1") || opc.equals("2") || opc.equals("3") || opc.equals("4") );

    
    }
}
