INC=$(shell pkg-config --cflags imas-gfortran)
LIB=$(shell pkg-config --libs imas-gfortran)

all:
	gfortran $(LIB) $(INC) -o bin/main src/main.f90 

clean:
	-rm bin/main
