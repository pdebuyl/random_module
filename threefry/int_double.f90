program int_double
  use iso_c_binding
  use threefry_module
  implicit none

  type(threefry_t) :: c, k

  c%c0 = 0
  c%c1 = 0
  k%c0 = 0
  k%c1 = 0

  write(*,'(f20.16)') threefry_double(c,k)
  write(*,'(f20.16)') threefry_double(c,k)
  write(*,'(f20.16)') threefry_double(c,k)
  write(*,'(f20.16)') threefry_double(c,k)

end program int_double
