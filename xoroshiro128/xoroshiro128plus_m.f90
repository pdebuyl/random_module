module xoroshiro128plus_m
  use, intrinsic :: iso_c_binding
  implicit none

  interface
     function next(s) result(r) bind(c, name='next')
       use, intrinsic :: iso_c_binding
       integer(kind=c_int64_t), dimension(2) :: s
       integer(kind=c_int64_t) :: r
     end function next
  end interface

  interface
     function next_double(s) result(r) bind(c, name='next_double')
       use, intrinsic :: iso_c_binding
       integer(kind=c_int64_t), dimension(2) :: s
       double precision :: r
     end function next_double
  end interface

end module xoroshiro128plus_m
