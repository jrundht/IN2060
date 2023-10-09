#include <stdio.h>
#include <stdlib.h>

extern "C" {int fibonacci(int a);}

int main(int argc, char** argv){
	if(argc != 2){
		printf("Trenger en inputverdi");
		return 1;
	}
	unsigned int a = atoi(argv[1]); //convert string to int
	printf("Fib av %d er: %d\n", a, fibonacci(a));
	return (0);
}
