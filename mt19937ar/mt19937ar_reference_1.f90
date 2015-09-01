program example
  use mt19937ar_type_module
  use mt19937ar_module
  use iso_c_binding
  implicit none

  type(mt19937ar_t) :: state

  integer(c_long) :: init(4) = [291, 564, 837, 1110]
  integer :: i
  integer(c_long) :: j

  call init_by_array(state, init)

  do i=1, 4
     write(*,'(i11)') genrand_int32(state)
  end do

  j = 0
  do i=1, 2000
     j = j + genrand_int32(state)
  end do

  do i=1, 4
     write(*,'(i11)') genrand_int31(state)
  end do

end program example
