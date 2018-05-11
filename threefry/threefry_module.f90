module threefry_type_module
  use iso_c_binding
  implicit none

  private
  public :: threefry_t
  public :: threefry_rng_t

  type, bind(c) :: threefry_t
     integer(c_long) :: c0
     integer(c_long) :: c1
  end type threefry_t

  type :: threefry_rng_t
     type(threefry_t) :: counter
     type(threefry_t) :: key
     double precision :: gauss
     logical :: has_gauss
  end type threefry_rng_t

end module threefry_type_module

module threefry_module
  use iso_c_binding
  use threefry_type_module
  implicit none

  private
  public :: threefry_t
  public :: threefry_rng_t
  public :: threefry_double
  public :: threefry_normal
  public :: threefry_rng_init

  interface threefry_rng_init
     module procedure threefry_rng_init_scalar
     module procedure threefry_rng_init_rank1
  end interface threefry_rng_init

  interface
     real(c_double) function threefry_double_c(c, k) bind(c, name='threefry_double')
       use iso_c_binding
       use threefry_type_module
       type(threefry_t) :: c
       type(threefry_t) :: k
     end function threefry_double_c
  end interface

contains

  subroutine threefry_rng_init_rank1(state, seed)
    type(threefry_rng_t), intent(out) :: state(:)
    integer(c_int64_t), intent(in) :: seed

    integer :: i, n

    n = size(state)

    do i = 1, n
       call threefry_rng_init_scalar(state(i), seed, int(i, c_int64_t))
    end do

  end subroutine threefry_rng_init_rank1

  subroutine threefry_rng_init_scalar(state, seed, c0)
    type(threefry_rng_t), intent(out) :: state
    integer(c_int64_t), intent(in) :: seed
    integer(c_int64_t), intent(in), optional :: c0

    state%counter%c0 = 0
    state%counter%c1 = 0
    if (present(c0)) then
       state%key%c0 = c0
    else
       state%key%c0 = 0
    end if
    state%key%c1 = seed
    state%has_gauss = .false.

  end subroutine threefry_rng_init_scalar

  !! Return a single [0,1[ double precision number
  function threefry_double(state) result(data)
    type(threefry_rng_t), intent(inout) :: state
    double precision :: data
    data = threefry_double_c(state%counter, state%key)
  end function threefry_double

  !! Return a normal-distributed random variable
  function threefry_normal(state) result(data)
    type(threefry_rng_t), intent(inout) :: state
    double precision :: data

    double precision :: u1, u2, radius
    logical :: found

    if ( state% has_gauss ) then
       data = state% gauss
       state% has_gauss = .false.
    else
       found = .false.
       do while (.not. found)
          u1 = 2*threefry_double_c(state%counter, state%key) - 1
          u2 = 2*threefry_double_c(state%counter, state%key) - 1
          radius = (u1**2+u2**2)
          if ( ( radius < 1 ) .and. (radius > 0) ) found = .true.
       end do
       state% gauss = u1 * sqrt( -2 * log(radius)/radius )
       state% has_gauss = .true.
       data = u2 * sqrt( -2 * log(radius)/radius )
    end if

  end function threefry_normal

end module threefry_module
