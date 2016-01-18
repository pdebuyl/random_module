program int_double
  use iso_c_binding
  use threefry_module
  implicit none

  type(threefry_rng_t) :: s

  s%counter%c0 = 0
  s%counter%c1 = 0
  s%key%c0 = 0
  s%key%c1 = 0

  write(*,'(f20.16)') threefry_double(s)
  write(*,'(f20.16)') threefry_double(s)
  write(*,'(f20.16)') threefry_double(s)
  write(*,'(f20.16)') threefry_double(s)

end program int_double
