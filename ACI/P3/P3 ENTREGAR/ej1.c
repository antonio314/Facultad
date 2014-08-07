#include <stdio.h>
#include <math.h>
#include <time.h>

struct {
	int a;
	int b;
}

s[500];
long ii,i;

main(int argc, char ** argv){

	clock_t start,stop;
	start= clock();

	for (ii=1;ii<=M;ii++){

		for (i=0;i<500;i++)
			s[i].a=2*s[i].a;

		for (i=0;i<500;i++)
			s[i].b=3*s[i].b;
	}

	stop = clock(); /* Final de medida de tiempo*/
	printf("%f \n",difftime(stop,start)/CLOCKS_PER_SEC);

	return 0;
}	
