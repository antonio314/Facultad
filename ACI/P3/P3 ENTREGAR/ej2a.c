#include <stdio.h> 
#include <math.h> 
#include <time.h>

#define N 50000000
float y[N];
float x[N]; 

long i;


main() {

	clock_t start,stop; 
	start= clock();
	
	for (i=1;i<=N;i++){
	
		y[i]=y[i]+5.0*x[i];
	} 


	stop = clock();	
	printf("%f \n",difftime(stop,start)/CLOCKS_PER_SEC);
	return 0;
}
