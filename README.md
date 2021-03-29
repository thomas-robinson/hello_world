# hello_world

## Singularity.fortran
To build the singularity Fortran container, you can use a `singularity build` command. This example uses **fakeroot** 
```sh
singularity build -f fortran.sif Singularity.fortran
```
You can then test the functionality of the container with different commands
```sh
singularity run fortran.sif
./fortran.sif
singularity exec fortran.sif hello.x
export SINGULARITYENV_HELLO="yo wassup"
singularity run fortran.sif
export SINGULARITYENV_HELLO="Hola mundo"
./fortran.sif
```
if using csh
```csh
singularity run fortran.sif
./fortran.sif
singularity exec fortran.sif hello.x
setenv SINGULARITYENV_HELLO "yo wassup"
singularity run fortran.sif
setenv SINGULARITYENV_HELLO "Hola mundo"
./fortran.sif
```

## Singularity.mpi
To build the singularity MPI continer, you follow pretty much the same procedure
```sh
singularity build -f mpi.sif Singularity.mpi
```
This container uses mpich, so you should use a compatible version of MPI (mvapich, impi, etc).
Do not use openmpi.

You can run the mpi.sif by using the appropriate MPI running command for your system on singularity
```sh
mpirun -n 10 singularity exec mpi.sif mpi_hello.x
mpirun -n 10 singularity run mpi.sif
```
Using slurm requires an extra argument to srun 
```sh
srun --mpi=pmi2 -n 10 singularity run mpi.sif
```
