# Which set of file will be compiled
REF = REF
threads = threads

#Implicit rules will be used to generate the public object files
PUBLICO = functions.o 

CC = gcc
CLIBS = -lm -lpthread
CFLAGS = -Wall -O3

all : $(REF)

$(REF) : $(REF).o $(threads).o $(PUBLICO)
	$(CC) -o $(REF) $(REF).o $(threads).o $(PUBLICO) $(CFLAGS) $(CLIBS)

$(REF)_1b : $(REF).o $(threads)_1b.o $(PUBLICO)
	$(CC) -o $(REF) $(REF).o $(threads).o $(PUBLICO) $(CFLAGS) $(CLIBS)

$(REF)_exp : $(REF)_exp.o $(threads)_exp.o $(PUBLICO)
	$(CC) -o $(REF)_exp $(REF)_exp.o $(threads)_exp.o $(PUBLICO) $(CFLAGS) $(CLIBS)

$(REF)_exp_b : $(REF)_exp.o $(threads)_exp_b.o $(PUBLICO)
	$(CC) -o $(REF)_exp_b $(REF)_exp.o $(threads)_exp_b.o $(PUBLICO) $(CFLAGS) $(CLIBS)

$(REF).o : $(REF).c REF.h
	$(CC) $(CFLAGS) -c $(REF).c

$(REF)_exp.o : $(REF)_exp.c REF.h
	$(CC) $(CFLAGS) -c $(REF)_exp.c

$(threads).o : $(threads).c REF.h
	$(CC) $(CFLAGS) -c $(threads).c

$(threads)_1b.o : $(threads)_1b.c REF.h
	$(CC) $(CFLAGS) -c $(threads)_1b.c

$(threads)_exp.o : $(threads)_exp.c REF.h
	$(CC) $(CFLAGS) -c $(threads)_exp.c

$(threads)_exp_b.o : $(threads)_exp_b.c REF.h
	$(CC) $(CFLAGS) -c $(threads)_exp_b.c

light : mt19937ar.c light.c
	$(CC) $(CFLAGS) -o light light.c -lgsl -lgslcblas 

profile : $(REF).o $(threads).o $(PUBLICO)
	$(CC) -o $(REF)_profile $(REF).o $(threads).o $(PUBLICO) $(CFLAGS) $(CLIBS) -pg 

test : testmarco.c
	$(CC) -o test testmarco.c $(CFLAGS) -lm

tar :
	tar -cf ./REF.tar options makefile *dat *.c *.h *.sh tissues

clean :
	rm *.o

cleantest :
	rm *test*

cleanboth : cleaninput cleanoutput

cleaninput :
	rm input*pho -f

cleanoutput :
	rm output*pho -f

tissue:tissue.c tissue.h mt19937ar.c
	$(CC) $(CFLAG) tissue.c -o tissue $(CLIB)
