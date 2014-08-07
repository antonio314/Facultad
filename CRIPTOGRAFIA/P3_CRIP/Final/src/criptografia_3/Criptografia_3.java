/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package criptografia_3;

import java.io.*;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author Jose Antonio Guerrero
 */
public class Criptografia_3 {

    /**
     * @param args the command line arguments
     */
    public static BigInteger potenciaModular(BigInteger a, BigInteger m, BigInteger c) //a=base, m=modulo, c=exponente
    {


        a = a.mod(m);
        c = c.mod(m);

        BigInteger cero = new BigInteger("0");
        BigInteger uno = new BigInteger("1");
        BigInteger dos = new BigInteger("2");
        BigInteger res = new BigInteger("1");


        while (c.compareTo(cero) != 0) //mientras c sea distinto de 0
        {
            if ((c.mod(dos)).compareTo(uno) == 0) {

                res = res.multiply(a);      //res=res*a;
                res = res.mod(m);           //res=res%m;

            }

            a = a.pow(2);   //a=a*a;
            a = a.mod(m);   //a=a%m;

            c = c.divide(dos);


        }

        res = res.mod(m);

        return res;

    }

    public static boolean es_primo(BigInteger n, BigInteger t) {//metodo de miller


        BigInteger cero = new BigInteger("0");
        BigInteger uno = new BigInteger("1");
        BigInteger dos = new BigInteger("2");
        BigInteger s = new BigInteger("1");
        BigInteger u = new BigInteger("0");
        BigInteger aux = new BigInteger("0");
        boolean pasa = true;
        boolean salir = false;

        Random rnd = new Random(2806L);

        s = n.subtract(uno);
        aux = s;

        while (aux.mod(dos).compareTo(cero) == 0) {

            s = s.divide(dos);
            u = u.add(uno);
            aux = s;


        }

        BigInteger i = new BigInteger("0");

        BigInteger b = new BigInteger("1");
        BigInteger j = new BigInteger("1");


        while (i.compareTo(t) != 0 && pasa == true) {

            salir = false;

            int al = (int) rnd.nextInt();

            BigInteger a = new BigInteger("0");
            a = BigInteger.valueOf(al);

            a = a.mod(n);

            b = potenciaModular(a, n, s);


            aux = n;
            aux = aux.subtract(uno);

            if (b.compareTo(uno) == 0 || b.compareTo(aux) == 0) {

                salir = true;
            }

            j = uno;

            while (j.compareTo(u) <= 0 && salir == false && pasa == true) {

                b = b.multiply(b).mod(n);

                aux = n;
                aux = aux.subtract(uno);

                if (b.compareTo(aux) == 0) {
                    salir = true;
                }

                if (b.compareTo(uno) == 0) {

                    pasa = false;


                }

                j = j.add(uno);

            }



            if (salir == false) {
                pasa = false;
            }

            i = i.add(uno);

        }

        if (pasa == true) {
            return true;
        } else {
            return false;
        }

    }

    private static BigInteger generarAleatorio(BigInteger min, BigInteger max) {
        Random r = new Random();
        BigInteger a = new BigInteger(max.bitLength(), r);

        while (a.compareTo(max) > 0 || a.compareTo(min) < 0) {
            a = new BigInteger(max.bitLength(), r);
        }

        return a;
    }

    public static void escribirStringEnFichero(String cadena, FileOutputStream fich) throws IOException {

        for (int i = 0; i < cadena.length(); i++) {
            fich.write((char) cadena.charAt(i));
        }

        fich.write('\n');   //le añado un \n despues de cada numero
    }

    public static void generarClaves() throws FileNotFoundException, IOException {

        File fPublicas = new File("clave.cpub");
        File fPrivada = new File("clave.cpriv");

        FileOutputStream publicas = new FileOutputStream(fPublicas);
        FileOutputStream privada = new FileOutputStream(fPrivada);



        BigInteger min = new BigInteger("2");
        BigInteger max = new BigInteger("2");
        BigInteger dos = new BigInteger("2");
        BigInteger uno = new BigInteger("1");
        BigInteger cero = new BigInteger("0");


        min = min.pow(159);
        max = max.pow(160);

        BigInteger q = generarAleatorio(min, max);


        BigInteger p = new BigInteger("0");
        BigInteger alpha = new BigInteger("0");
        BigInteger y = new BigInteger("0");

        BigInteger rondas = new BigInteger("10");

        if (q.mod(dos).compareTo(cero) == 0) // Si q es par
        {
            q = q.add(uno);
        }

        while (!es_primo(q, rondas)) {

            q = q.add(dos);

            if (q.bitLength() != 160) { // Comprobar que q no es mayor de 160 bits

                q = dos.pow(159);
                q = q.add(generarAleatorio(cero, dos.pow(159).subtract(dos)));

                if (q.mod(dos).compareTo(cero) == 0) // Si q es par
                {
                    q = q.add(uno);
                }
            }
        }

        
        System.out.println("Q:"+q);


        //vamos ha calcular p

        min = dos;
        max = dos;
        min = min.pow(351);
        max = max.pow(352);
        BigInteger c = generarAleatorio(min, max);

        if (c.mod(dos).compareTo(cero) != 0) // c tiene que ser par
        {
            c = c.add(uno);
        }

        

        p = c.multiply(q).add(uno);

        while (!es_primo(p, rondas) || p.bitLength() != 512){


            //si no es primo, sumo 2 a la c
            c = c.add(dos);
            
            if (c.bitLength() != 352) { // Comprobar que c no es mayor de 352 bits

                
                c = dos.pow(351);
                c = c.add(generarAleatorio(cero, dos.pow(351).subtract(dos)));

                if (c.mod(dos).compareTo(cero) != 0) // c tiene que ser par
                {
                    c = c.add(uno);
                }
            }

            p = c.multiply(q).add(uno);

        }



        //escribo p en el fichero de claves publicas
        escribirStringEnFichero(p.toString(), publicas);
        
        //escribo q en el fichero de claves publicas
        escribirStringEnFichero(q.toString(), publicas);


        //ahora calculamos x

        BigInteger g = generarAleatorio(dos, p.subtract(dos));

        while (potenciaModular(g, p, c).compareTo(uno) == 0) {

            g = g.add(uno);

            if (g.compareTo(p.subtract(uno)) == 0) {

                g = generarAleatorio(dos, p.subtract(dos));

            }

        }

        alpha = potenciaModular(g, p, c);




        //escribo alpha en el fichero de claves publicas
        escribirStringEnFichero(alpha.toString(), publicas);

        //calculo de la clave privada
        BigInteger x = generarAleatorio(dos, q.subtract(dos));

        //escribo x en el fichero de clave privada
        escribirStringEnFichero(x.toString(), privada);

        // calculo de y
        y = potenciaModular(alpha, p, x);


        //escribo y en el fichero de claves publicas
        escribirStringEnFichero(y.toString(), publicas);
        
   }

    public static int charToInt(char c) {
        //necesito pasar un char a int, para ello: char->char[]->String->int
        char[] rc = new char[1];
        rc[0] = c;
        String saux = new String(rc);
        int resultado = Integer.parseInt(saux);

        return resultado;
    }

    //recibe un ArrayList de char (con enteros) y devuelve el BigInteger asociado
    public static BigInteger arrayListDeEnterosToBigInteger(ArrayList<Character> s) {

        BigInteger diez = new BigInteger("10");

        BigInteger pos = new BigInteger("10");
        int cont = s.size() - 1;

        BigInteger resultado = BigInteger.valueOf(s.get(cont) - 48);

        cont--;

        while (cont >= 0) //bucle decreciente
        {

            //paso el char leido a int
            int aux = (char) s.get(cont) - 48;

            BigInteger aux2 = new BigInteger("0");
            aux2 = BigInteger.valueOf(aux);


            aux2 = aux2.multiply(pos);

            resultado = resultado.add(aux2);

            pos = pos.multiply(diez);
            cont--;
        }

        return resultado;
    }

    public static String generateHash(File file) throws NoSuchAlgorithmException, FileNotFoundException, IOException {
        MessageDigest md = MessageDigest.getInstance("SHA1"); // SHA or MD5
        String hash = "";

        byte[] data = new byte[(int) file.length()];
        FileInputStream fis = new FileInputStream(file);
        fis.read(data);
        fis.close();

        md.update(data); // Reads it all at one go. Might be better to chunk it.

        byte[] digest = md.digest();

        for (int i = 0; i < digest.length; i++) {
            String hex = Integer.toHexString(digest[i]);
            if (hex.length() == 1) {
                hex = "0" + hex;
            }
            hex = hex.substring(hex.length() - 2);
            hash += hex;
        }

        return hash;
    }

    public static void firma(String nombreArchivo,File ficheroFirmar, String clavesPublicas, String clavePrivada) throws FileNotFoundException, IOException, NoSuchAlgorithmException {


        //leo todas las claves publicas y la privada

        File fPublicas = new File(clavesPublicas);
        File fPrivada = new File(clavePrivada);

        FileInputStream publicas = new FileInputStream(fPublicas);
        FileInputStream privada = new FileInputStream(fPrivada);


        boolean fin = false;
        boolean quedanClaves = true;
        char c;
        ArrayList clave = new ArrayList();  //ArrayList de char donde ire metiendo las cifras del numero que se esta leyendo en ese momento
        ArrayList todasClavesPublicas = new ArrayList();    //aqui metere las cuatro claves publicas
        while (!fin) {
            //leo el caracter del fichero
            c = (char) publicas.read();


            if (c == '\n') //si he llegado a un '\n' paso lo que tenga en el ArrayList auxiliar a BigInteger 
            {
                //paso a BigInteger
                todasClavesPublicas.add(arrayListDeEnterosToBigInteger(clave));

                //limpio el contenido de clave
                clave.clear();

            } else if (c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9' || c == '0') {
                clave.add(c); //mete esa cifra al final del arraylist
            }


            if (publicas.available() == 0) {
                fin = true;
            }

        }

        //para que tambien pase la ultima clave (no va seguida de un '\n')
        //todasClavesPublicas.add( arrayListDeEnterosToBigInteger(clave) );         

        //ya tendre en todasClavesPublicas las claves p,q,alpha,y
        BigInteger q = (BigInteger) todasClavesPublicas.get(1);
        BigInteger p = (BigInteger) todasClavesPublicas.get(0);
        BigInteger alpha = (BigInteger) todasClavesPublicas.get(2);
        BigInteger y = (BigInteger) todasClavesPublicas.get(3);
        
        //ahora leo la clave privada x:
        c = 'a';
        
        //limpio el contenido de clave
        clave.clear();

        while (c != '\n') {

            c = (char) privada.read();

            if (c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9' || c == '0') {
                clave.add(c); //mete esa cifra al final del arraylist
            }

        }

        //ahora transformo el array en el BigInteger
        BigInteger x = arrayListDeEnterosToBigInteger(clave);

        //AQUI YA TENDREMOS TODAS LAS CLAVES LEIDAS EN LAS VARIABLES

        String aux = nombreArchivo;
        
        
        aux = aux.concat(".firm");
        
        File fS = new File(aux);
        FileOutputStream salida = new FileOutputStream(fS);

        BigInteger dos = new BigInteger("2");
        BigInteger uno = new BigInteger("1");
        BigInteger cero = new BigInteger("0");

        

        String mensaje_sha1 = generateHash(ficheroFirmar);

        //aqui guardare el sha-1 del mensaje, ahora mismo esta guardado en el String mensaje_sha1
        BigInteger h_m = new BigInteger(mensaje_sha1,16);


        BigInteger r = new BigInteger("0");
        BigInteger s = new BigInteger("0");

        
         BigInteger k = generarAleatorio(dos, q.subtract(dos) );
         
         r = potenciaModular(potenciaModular(alpha,p,k),q,uno);
         
         s = potenciaModular(h_m.add(x.multiply(r)).multiply(k.modInverse(q)),q,uno);

        //escribo r,s en el fichero de salida
        escribirStringEnFichero(r.toString(), salida);
        escribirStringEnFichero(s.toString(), salida);
        
        System.out.println("El nombre del archivo firmado es: "+aux);


    }

    public static boolean comprobarFirma(File ficheroFirmado, String clavesPublicas, String ficheroRS) throws FileNotFoundException, IOException, NoSuchAlgorithmException {

        //leo todas las claves publicas y la privada

        File fPublicas = new File(clavesPublicas);

        FileInputStream publicas = new FileInputStream(fPublicas);

        boolean fin = false;
        boolean quedanClaves = true;
        char c;
        ArrayList clave = new ArrayList();  //ArrayList de char donde ire metiendo las cifras del numero que se esta leyendo en ese momento
        ArrayList todasClavesPublicas = new ArrayList();    //aqui metere las cuatro claves publicas
        while (!fin) {
            //leo el caracter del fichero
            c = (char) publicas.read();


            if (c == '\n') //si he llegado a un '\n' paso lo que tenga en el ArrayList auxiliar a BigInteger 
            {
                //paso a BigInteger
                todasClavesPublicas.add(arrayListDeEnterosToBigInteger(clave));

                //limpio el contenido de clave
                clave.clear();

            } else if (c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9' || c == '0') {
                clave.add(c); //mete esa cifra al final del arraylist
            }


            if (publicas.available() == 0) {
                fin = true;
            }

        }

        
        
        
        //para que tambien pase la ultima clave (no va seguida de un '\n')
        //todasClavesPublicas.add( arrayListDeEnterosToBigInteger(clave) );         

        //ya tendre en todasClavesPublicas las claves p,q,alpha,y
        BigInteger q = (BigInteger) todasClavesPublicas.get(1);
        BigInteger p = (BigInteger) todasClavesPublicas.get(0);
        BigInteger alpha = (BigInteger) todasClavesPublicas.get(2);
        BigInteger y = (BigInteger) todasClavesPublicas.get(3);
        
        /*System.out.println("Q:" + q);
        System.out.println("P:" + p);
        System.out.println("A:" + alpha);
        System.out.println("Y:" + y);
        */
        
        
        
        File fRS = new File(ficheroRS);

        FileInputStream faux = new FileInputStream(fRS);

        fin = false;
        quedanClaves = true;
        char c1;
        ArrayList clave1 = new ArrayList();  //ArrayList de char donde ire metiendo las cifras del numero que se esta leyendo en ese momento
        ArrayList todasClaves = new ArrayList();    //aqui metere las cuatro claves publicas
        while (!fin) {
            //leo el caracter del fichero
            c1 = (char) faux.read();


            if (c1 == '\n') //si he llegado a un '\n' paso lo que tenga en el ArrayList auxiliar a BigInteger 
            {
                //paso a BigInteger
                todasClaves.add(arrayListDeEnterosToBigInteger(clave1));

                //limpio el contenido de clave
                clave1.clear();

            } else if (c1 == '1' || c1 == '2' || c1 == '3' || c1 == '4' || c1 == '5' || c1 == '6' || c1 == '7' || c1 == '8' || c1 == '9' || c1 == '0') {
                clave1.add(c1); //mete esa cifra al final del arraylist
            }


            if (faux.available() == 0) {
                fin = true;
            }

        }
        
        
        BigInteger r = (BigInteger) todasClaves.get(0);
        BigInteger s = (BigInteger) todasClaves.get(1);
        
        BigInteger dos = new BigInteger("2");
        BigInteger uno = new BigInteger("1");
        BigInteger cero = new BigInteger("0");

        String mensaje_sha1 = generateHash(ficheroFirmado);

        //aqui guardare el sha-1 del mensaje, ahora mismo esta guardado en el String mensaje_sha1
        BigInteger h_m = new BigInteger(mensaje_sha1,16);

         
         
        BigInteger u = potenciaModular(h_m.multiply(s.modInverse(q)),q,uno);

        BigInteger v = potenciaModular(r.multiply(s.modInverse(q)),q,uno);

       // BigInteger r1 = potenciaModular(potenciaModular(alpha,p, u).multiply(potenciaModular(y,p,v)),q,uno);
        BigInteger r1 = potenciaModular(potenciaModular(potenciaModular(alpha, p, u).multiply(potenciaModular(y,p,v)), p, uno),q,uno);
         

          if(r1.compareTo(r) == 0)
         
          return true;
         
          else
         
          return false;
         
    }

    public static void main(String[] args) throws FileNotFoundException, IOException, NoSuchAlgorithmException {
        // TODO code application logic here
        
        BufferedReader teclado = new BufferedReader(new InputStreamReader(System.in));

        String opc, archivo, publica, privada, firmado;
        
        do{
        
        System.out.println("------------------------MENU--------------------\n"
                + " 1.- GenerarClaves\n"
                + " 2.- Firmar un archivo\n"
                + " 3.- Comprobar firma\n"
                + " 4.- Miller Rabin\n"
                + " 0.- Salir");
        
        System.out.println("Introduce la opcion que desee: ");
        
        opc = teclado.readLine();

            
        if(opc.equals("0") )
        {
            System.out.println("FIN DEL PROGRAMA\n");
        }
        
        if(opc.equals("1")){
            
            generarClaves();
            
            System.out.println("Se han generado las claves:\n"
                    + "El archivo con la clave publica se llama: clave.cpub\n"
                    + "El archivo con la clave privada se llama: clave.cpriv");
        
        }
        if(opc.equals("2")){
        
            System.out.println("Introduce el archivo a firmar: ");
            archivo = teclado.readLine();
            File archivoFirmar = new File(archivo);
            
            System.out.println("Introduce el archivo de las claves publicas: ");
            publica = teclado.readLine();
            
            System.out.println("Introduce El archivo de la clave privada: ");
            privada = teclado.readLine();
            
            firma(archivo,archivoFirmar, publica, privada);
            
            
        
        }

        if(opc.equals("3")){
        
            System.out.println("Introduce el archivo a comprobar con la firma: ");
            archivo = teclado.readLine();
            File archivoFirmar = new File(archivo);
            
            System.out.println("Introduce el archivo donde esta la clave publica: ");
            publica = teclado.readLine();
            
            System.out.println("Introduce el archivo firmado: ");
            firmado = teclado.readLine();
            
            
            if(comprobarFirma(archivoFirmar, publica, firmado))
                System.out.println("Se acepta la firma");
            else
                System.out.println("No se acepta la firma");
        
        
        }
        
        if(opc.equals("4")){
            
            System.out.println("Test de Miller Rabin\n");
                    

            System.out.println("Introduce un numero: ");
            String n = teclado.readLine();

            System.out.println("Introduce el numero de rondas: ");
            String r = teclado.readLine();
            
            BigInteger num = new BigInteger(n);
            BigInteger ron = new BigInteger(r);
            
            if(es_primo(num,ron)){
            
                    System.out.println("El número "+num+" es primo");
                    
            }
            else{
            
                    System.out.println("El número "+num+" no es primo");
                    
            }
        
        
        }
        

        
        }while(!(opc.equals("0")));
        
    }
}
