module threefry_type_module
  use iso_c_binding
  implicit none

  private
  public :: threefry_t

  type, bind(c) :: threefry_t
     integer(c_long) :: c0
     integer(c_long) :: c1
  end type threefry_t

end module threefry_type_module

module threefry_module
  use iso_c_binding
  use threefry_type_module
  implicit none

  private
  public :: threefry_t
  public :: threefry_double

  interface
     real(c_double) function threefry_double(c, k) bind(c, name='threefry_double')
       use iso_c_binding
       use threefry_type_module
       type(threefry_t) :: c
       type(threefry_t) :: k
     end function threefry_double
  end interface

end module threefry_module
