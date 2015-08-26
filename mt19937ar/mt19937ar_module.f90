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
  public :: mt19937ar_t
  public :: init_by_array, genrand_int32, genrand_int31, init_genrand
  public :: genrand_real1, genrand_real2, genrand_real3
  public :: mt_normal, mt_normal_data

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

  interface
     real(c_double) function genrand_real2(s) bind(c, name='genrand_real2')
       use iso_c_binding
       use mt19937ar_type_module
       type(mt19937ar_t) :: s
     end function
  end interface

  interface
     real(c_double) function genrand_real3(s) bind(c, name='genrand_real3')
       use iso_c_binding
       use mt19937ar_type_module
       type(mt19937ar_t) :: s
     end function
  end interface

  interface mt_normal_data
     module procedure mt_normal_data_d_1
     module procedure mt_normal_data_d_2
  end interface mt_normal_data

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

  !! Return a normal-distributed random variable
  function mt_normal(state) result(data)
    type(mt19937ar_t), intent(inout) :: state
    double precision :: data

    double precision :: u1, u2, radius
    logical :: found

    if ( state% has_gauss ) then
       data = state% gauss
       state% has_gauss = .false.
    else
       found = .false.
       do while (.not. found)
          u1 = 2*genrand_real1(state) - 1
          u2 = 2*genrand_real1(state) - 1
          radius = (u1**2+u2**2)
          if ( ( radius < 1 ) .and. (radius > 0) ) found = .true.
       end do
       state% gauss = u1 * sqrt( -2 * log(radius)/radius )
       state% has_gauss = .true.
       data = u2 * sqrt( -2 * log(radius)/radius )
    end if

  end function mt_normal

  subroutine mt_normal_data_d_1(data, state)
    double precision, intent(inout) :: data(:)
    type(mt19937ar_t), intent(inout) :: state

    integer :: i

    do i = 1, size(data, dim=1)
       data(i) = mt_normal(state)
    end do

  end subroutine mt_normal_data_d_1

  subroutine mt_normal_data_d_2(data, state)
    double precision, intent(inout) :: data(:,:)
    type(mt19937ar_t), intent(inout) :: state

    integer :: i, j

    do j = 1, size(data, dim=2)
    do i = 1, size(data, dim=1)
       data(i,j) = mt_normal(state)
    end do
    end do

  end subroutine mt_normal_data_d_2

end module mt19937ar_module
