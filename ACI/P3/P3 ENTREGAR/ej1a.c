#include <stdio.h>
#include <math.h>
#include <time.h>

struct {
	int a;
	int b;
} 
s[500];
long ii,i;

main(int argc, char ** argv) {

	clock_t start,stop;
	start= clock(); 

	for (ii=1;ii<=M;ii++){

		for (i=0;i<500;i++){

			s[i].a=2*s[i].a;
			s[i].b=3*s[i].b;
			s[i+1].a=2*s[i+1].a;
			s[i+1].b=3*s[i+1].b;
			s[i+2].a=2*s[i+2].a;
			s[i+2].b=3*s[i+2].b;
			s[i+3].a=2*s[i+3].a;
			s[i+3].b=3*s[i+3].b;
			s[i+4].a=2*s[i+4].a;
			s[i+4].b=3*s[i+4].b;
			
		}
	}

	stop = clock(); 
	printf("%f \n",difftime(stop,start)/CLOCKS_PER_SEC);

	return 0;
}

