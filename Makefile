FC=gfortran
FFLAGS=-O3 -Wall -Wextra
CC=gcc
SRC_F=iritest.for irisub.for irifun.for iritec.for iridreg.for igrf.for cira.for iriflip.for
SRC_C=main.c
TEST=iritest.for
OBJ_F=${SRC:.for=.o}
OBJ_C=main.o

%.o: %.for
	$(FC) $(FFLAGS) -o $@ -c $<

iriexe: $(OBJ_F)
	$(FC) $(FFLAGS) -o $@ $(OBJ_F)

irilibrary.so : $(OBJ_F)
	$(FC) $(FFLAGS) -o $@ $(OBJ_F)

iri-c : $(OBJ_F) run_iri.o irilibrary.so $(OBJ_C)
	$(FC) $(FFLAGS) -o $@ $(OBJ_C) -L./ -lgfortran -liri

fortan_o: $(OBJ_F) run_iri.o
$(OBJ_F) : %.o : %.for run_iri.f08
	$(FC) $(FFLAGS) -fPIC -c $< $@


run_iri.o: run_iri.f08
	$(FC) $(FFLAGS) -c $<

#building with C

$(OBJ_C) : %.o : %.cira
	$(FC) $(FFLAGS) -fPIC -c $< -o $@

clean:
	rm -rf *.o iri-c iriexe

clear-iri-c:
	rm -rf main.o c-iri