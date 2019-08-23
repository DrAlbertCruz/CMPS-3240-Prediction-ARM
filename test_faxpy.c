#include <stdlib.h>

void faxpy( int length, float* x, float* y, float* result );

int main() {
	const int n = 400000000;
	float *x = (float *) malloc( sizeof( float ) * n );
	float *y = (float *) malloc( sizeof( float ) * n );
	float *result = (float *) malloc( sizeof( float ) * n );

	faxpy( n, x, y, result );

	free( x );
	free( y );
	free( result );
}
