FC=gfortran
FFLAGS=-O3 -Wall -Wextra
SRC=iritest.for irisub.for irifun.for iritec.for iridreg.for igrf.for cira.for iriflip.for
TEST=iritest.for
OBJ=${SRC:.for=.o}

%.o: %.for
	$(FC) $(FFLAGS) -o $@ -c $<

irimodel: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)
