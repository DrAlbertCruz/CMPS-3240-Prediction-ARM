CC=gcc
FLAGS=-Wall -O0

all: faxpyPre.out faxpyPost.out

faxpyPre.out: faxpyPre.o test_faxpy.o
	$(CC) $(FLAGS) $^ -o $@
test_faxpy.o: test_faxpy.c
	$(CC) $(FLAGS) -c $< -o $@
faxpyPre.o: faxpyPre.s
	$(CC) $(FLAGS) -c $< -o $@
faxpyPost.out: faxpyPost.o test_faxpy.o
	$(CC) $(FLAGS) $^ -o $@
faxpyPost.o: faxpyPost.s
	$(CC) $(FLAGS) -c $< -o $@

clean: 
	rm -r -f *.o *.out
