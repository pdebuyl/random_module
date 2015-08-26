module mt19937ar_type_module
  use iso_c_binding
  implicit none

  private
  public :: mt19937ar_t

  integer, parameter :: N=624

  type, bind(c) :: mt19937ar_t
     integer(c_long) :: mt(N)
     integer(c_int) :: mti
     real(c_double) :: gauss
     logical(c_bool) :: has_gauss
  end type mt19937ar_t

end module mt19937ar_type_module

module mt19937ar_module
  use iso_c_binding
  use mt19937ar_type_module
  implicit none

  private
  public :: init_by_array, genrand_int32, genrand_int31, genrand_real1, init_genrand

  interface
     subroutine init_genrand(s, seed) bind(c, name='init_genrand')
       use iso_c_binding
       use mt19937ar_type_module
       type(mt19937ar_t) :: s
       integer(c_long), value :: seed
     end subroutine init_genrand
  end interface

  interface
     integer(c_long) function genrand_int32(s) bind(c, name='genrand_int32')
       use iso_c_binding
       use mt19937ar_type_module
       type(mt19937ar_t) :: s
     end function
  end interface

  interface
     integer(c_long) function genrand_int31(s) bind(c, name='genrand_int31')
       use iso_c_binding
       use mt19937ar_type_module
       type(mt19937ar_t) :: s
     end function
  end interface

  interface
     real(c_double) function genrand_real1(s) bind(c, name='genrand_real1')
       use iso_c_binding
       use mt19937ar_type_module
       type(mt19937ar_t) :: s
     end function
  end interface

contains

  subroutine init_by_array(state, init)
    type(mt19937ar_t), target :: state
    integer(c_long), target :: init(:)
    interface
       subroutine init_by_array_c(s, init_key, key_length) bind(c, name='init_by_array')
         use iso_c_binding
         use mt19937ar_type_module
         type(mt19937ar_t) :: s
         integer(c_long) :: init_key(key_length)
         integer(c_int), value :: key_length
       end subroutine init_by_array_c
    end interface

    call init_by_array_c(state, init, int(size(init), c_int))

  end subroutine init_by_array

end module mt19937ar_module
