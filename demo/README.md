# Singularity Demo

## Singularity commands
(`module load singularity`)
### singularity shell
Opens a shell in a given container
Commands issued are in the container
Output will be saved if you put it in a host directory 
Home is usually bound to the container
Depending on the version and set up, $PWD may be bound
```
singularity shell docker://ubuntu:latest
Singularity> hostname 
Singularity> cat /etc/os-release
Singularity> exit
> hostname
> cat /etc/os-release
```
### singularity pull
Pulls the container from a remote
Saves the container as a .sif file
```
singularity pull docker://ubuntu:latest
> ls
```
### Singularity exec
Run a command in the container (the typical way of using singularity)
```
singularity exec ubuntu_latest.sif cat /etc/os-release
```
`--bind=` or `-B` option to bind specific directories/files.  Use this option if you aren’t running in your home directory
```
singularity exec -B $PWD ubuntu_latest.sif cat /etc/os-release
singularity exec -B $PWD,/etc/os-release ubuntu_latest.sif cat /etc/os-release
```
You haven’t changed the OS, you just included this file as a trick

### Singularity run
Run the runscript in the container (more on this later)
```
singularity run <file.sif>
```

## [Singularity environment variables](https://sylabs.io/guides/3.0/user-guide/appendix.html)

**SINGULARITY_BINDPATH** and **SINGULARITY_BIND**: Comma separated string source:<dest> list of paths to bind between the host and the container.

**SINGULARITYENV_VARIABLE** - Set the environment variable VARIABLE to whatever you set
```
> setenv SINGULARITYENV_HELLO "yo wassup" 
> singularity exec -B $PWD ubuntu_latest.sif env | grep HELLO
HELLO=yo wassup
```
**SINGULARITYENV_PATH**: A specified path to override the $PATH environment variable within the container.
**SINGULARITYENV_APPEND_PATH**: Used to append directories to the end of the `$PATH` environment variable.
**SINGULARITYENV_PREPEND_PATH**: Used to prepend directories to the beginning of `$PATH` environment variable.


## Building a container
### Singularity build

*If you don’t have root privileges, you need to use the -f --fakeroot option*
The system must be set up to allow you to build.  Currently (March 2021) orion and gaea do not allow `singularity build -f`.

[Instructions on building this demo Fortran container](https://github.com/thomas-robinson/hello_world)


