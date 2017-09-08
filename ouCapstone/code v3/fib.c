#include <stdio.h>

int fib(n)
{
	if (n <= 2)
		return 1;
	else
		return fib(n-1) + fib(n-2);
}

int main(int argc, char **argv) 
{
	int n;
	if (argc < 2) {
		char string[80];
		printf("What Fibonacci Number would you like to compute? ");
		scanf("%s",string);
		getchar();
		n = atoi(string);
		printf("fib(%d) = %d\n", n, fib(n));
		printf("Press [ENTER] to close");
		while( getchar() != '\n' );
	    return 0;
	} else {	
		n = atoi(argv[1]);
		printf("fib(%d) = %d\n", n, fib(n));
		return 0;
	}
}
