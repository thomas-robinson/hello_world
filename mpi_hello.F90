program mpi_hello
  use mpi

      integer :: ierr, irank, isize

      call MPI_INIT (ierr)
      call MPI_COMM_RANK (MPI_COMM_WORLD, irank, ierr)
      call MPI_COMM_SIZE (MPI_COMM_WORLD, isize, ierr)

      write (6,*)"Hello from rank ",irank," of ",isize

      call MPI_FINALIZE (ierr)

end program mpi_hello
