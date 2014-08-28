
struct dobleString {
    string primero <64>;
    string segundo <2048>;
};
program SERVIDORARCHIVOS {
	version SERVIDORARCHIVOSVERS {
	   
		    int CREAR(string) = 1;
		    string ESCRIBIR(dobleString) = 2;
		    string LEER(string) = 3;
		    int RENOMBRAR(dobleString) = 4;
		    int CREARDIR(string) = 5;
		    int BORRARDIR(string) = 6;
		   
	} = 1;
} = 0x20000001;


