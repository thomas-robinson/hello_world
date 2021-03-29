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

### The singularity DEF file
Singularity containers are made from .def files.  The def file used in this demo is [Singularity.fortran](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran).  It has several sections and uses a multi-step build process.
#### Header
[Bootstrap](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L25): Describes the type of base container you will be using
[From](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L26): The base container you will be using
[Stage](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L27): This is a tag for the stage of the container build.  You can use whatever you want here.
#### %files
Lists files you want from the host system or from different stages.  Although there is a blank section in my
example, you don't need to include this if there are no files.  You can specify the end location for a file 
by using a :.  If you don't use a :, it will end up in the same path in the container as the host.
```
/path/on/host:/path/in/container
```
[In the second stage of the build](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L25), 
the files come from the first stage named build. This is the only file that I bring over.  This is particularly useful if you 
build a model and do not need the .o and .mod files.  You can just put the executable in the %files section of the second 
stage of the container build.  
#### %post
This is where you create everything that you want in the container as the root.  You can build software, modify files, etc.
It reads like a script (unlike a Dockerfile where each RUN line is entirely new).  If you want to set environment variables to 
use in this section, you should do so by using `export`, and not by setting them in the %environment section of the def file.

I get the libraries [git](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L9) and 
[gcc-fortran](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L10), then checkout my 
code and build the executable.  I also move the executable to a different location so that I can just [bring the executable 
over in the second stage %files sectio]n(https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L26)

#### %environment
Set up environment varibales that you want during the execution of the container.  Setting variables in the %environment 
section **does not** set them for the %post section.  I update the path to include my executable.

#### %runscript
A script that will be run during `singularity run` or by executing the container. 
[My script](https://github.com/thomas-robinson/hello_world/blob/main/Singularity.fortran#L35) does weird things as a demo.

### Singularity build

*If you don’t have root privileges, you need to use the -f --fakeroot option*
The system must be set up to allow you to build.  Currently (March 2021) orion and gaea do not allow `singularity build -f`.

[Instructions on building this demo Fortran container](https://github.com/thomas-robinson/hello_world)

