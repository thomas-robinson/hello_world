# hello_world

##Singularity.fortran
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
