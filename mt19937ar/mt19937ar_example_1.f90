!! This program generates 100 random numbers distributed according to a normal distribution
!! and writes them to the file normal_values.txt and 100 numbers according to a uniform
!! distribution and stores them in the file uniform_double_values.txt
!!
!! One command line parameter is accepted. If given, it is used as the seed to
!! the random number generator.

program example
  use mt19937ar_module
  use iso_c_binding
  implicit none

  type(mt19937ar_t) :: state

  integer :: i
  integer(c_long) :: seed
  character(len=32) :: arg

  if ( command_argument_count() < 1 ) then
     call system_clock(seed)
     call init_genrand(state, int(seed, c_long))
  else
     call get_command_argument(1, arg)
     read(arg, *) seed
     call init_genrand(state, seed)
  end if

  open(12, file='normal_values.txt')
  do i = 1, 100
     write(12,*) mt_normal(state)
  end do
  close(12)

  open(12, file='uniform_double_values.txt')
  do i = 1, 100
     write(12,*) genrand_real1(state)
  end do
  close(12)

end program example
